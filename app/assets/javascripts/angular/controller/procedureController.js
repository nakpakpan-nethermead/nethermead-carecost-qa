var myApp = angular.module('myApp',['AngularGM']);

myApp.service('Procedure',function($http){
  var procedures = [];

  var add = function(list) {
    procedure = list.split(',');
    $.each(procedure, function(index,value) {
      if (procedure != '')
        $http.get('/procedure/price/'+value).success(function(response) {
          procedures.push(response);
        });
    });

    setTimeout(function(){
        $("#physicianProcedure").val(0);
    },500);
  }

  var destroy = function(index) {
    procedures.splice(index,1);
  }

  var removeCityCost = function(index,$scope) {
    for(i=0;i<procedures.length;i++) {
      procedures[i].charge.splice(index-1,1);
    }

  }

  var filter = function(cities,index) {
    
    var toSend = {};
    toSend["procedures"] = [];
    if(index == -1)
      toSend["procedures"].push(procedures);
    else
      toSend["procedures"].push(procedures[index]);

    toSend["cities"] = [];
    toSend["cities"].push(cities);
    // toSend['current_facility'] = procedures[index].current_facility;
    // toSend['current_network'] = procedures[index].current_network;
    // toSend['id'] = procedures[index].id;

    
    $http({
      url: '/procedure/price/1',
      method: 'GET',
      params: toSend
    }).success(function (result) {
      // console.log(result);
      for(i=0;i<procedures.length;i++) {
        for(j=0;j<result.length;j++) {
          if(procedures[i].id == result[j].id){
            procedures[i] = result[j];
          }
        }
      }
      setTimeout(function(){
        $(".slider-range:last").slider('option', 'change')()
      },50);
    });
  }

  var calculatePrice = function(s){
    for(i=0;i<procedures.length;i++) {
      $.each(procedures[i].charge , function(key,val){
        var newCharge = val.originalVal - s.netDedutable;
        newCharge = (newCharge * s.netInsurance)/100;
        newCharge =  newCharge + s.netDedutable + s.copayValue;
        procedures[i].charge[key]["val"] = newCharge;
      });
    }
  }


  var emailShare = function(cities){
    var email = $('#contact-email').val();
    var message = $('#email-msg').val();
    toSend = {}
    toSend["procedures"] = [];
    toSend["cities"] = [];
    toSend["procedures"].push(procedures);
    toSend["cities"].push(cities);
    toSend["email"] = email;
    toSend["message"] = message;

    $http({
      url: '/dashboard/email_share',
      method: 'GET',
      params: toSend
    }).success(function (response) {
      alert("Email Sent.")
    });
  }

  return {
    emailShare: emailShare,
    calculatePrice: calculatePrice,
    add: add,
    destroy: destroy,
    removeCityCost: removeCityCost,
    filter: filter,
    all: procedures
  };
})

myApp.service('City',function($http){
  var cities = [];

  var add = function(data,dataId,dataType,dataDisType,state) {
    var width = $("#costTable").width();
    var slider_width = $(".sliding-window").width();
    $("#costTable").width(width+175);
    $(".sliding-window").width(slider_width+175);
    var tmpCity = {}
    tmpCity["data"] = data;
    tmpCity["dataId"] = dataId;
    tmpCity["dataType"] = dataType;
    tmpCity["dataDisType"] = dataDisType;
    tmpCity["state"] = state;
    cities.push(tmpCity);

    $.each(cities, function(key,value){
      console.log(value.state);
      var data = {};
      data[value.state] = {fillKey: 'zipFound'}
      world.updateChoropleth(data);
    });

    setTimeout(function(){
      $("#locationAdded").find('option:eq(1)').prop('selected', true);
    },500);
  }

  var destroy = function(index) {
    var data = {};
    data[cities[index-1].state] = {fillKey: 'defaultFill'}
    world.updateChoropleth(data);
    cities.splice(index-1,1);
    var slider_width = $(".sliding-window").width();
    var width = $("#costTable").width();
    $("#costTable").width(width-175);
    $(".sliding-window").width(slider_width-175);
    setTimeout(function(){
      $("#locationAdded").find('option:eq(1)').prop('selected', true);
    },100);
  }

  return {
    add: add,
    destroy: destroy,
    all: cities
  };
})

myApp.service('Physician',function($http){
  var physicians = [];
  var toSend = {};

  var refresh = function(fetch, location, $q) {
    
    physicians.splice(0,physicians.length);

    toSend['selectedPro'] = fetch;
    toSend['location'] = location;

    $http({
      url: '/provider/',
      method: 'GET',
      params: toSend
    }).success(function (response) {
      $.each(response, function(index, value){
        physicians.push(value);
      });
    });
  }

  var highPrice = function(){
    var highPrice = false;
    var high = 0;
    angular.forEach(physicians, function(physician, key) {
      if (physician.cost['price'] < high || highPrice === false) {
        high = value;
        highPrice = true;
      }
    });
    return high;
  }

  var makeFav = function(id,myphyPro){
    var toSend = {};
    toSend['provider_id'] = id;
    toSend['procedure_id'] = myphyPro;
    $http({
      url: '/provider/makefav',
      method: 'GET',
      params: toSend
    }).success(function (response) {
      
    });
  }

  var updatePrice = function(s){
    angular.forEach(physicians, function(physician, key) {
        var newCharge = physician.cost['originalPrice'] - s.netDedutable;
        newCharge = (newCharge * s.netInsurance)/100;
        newCharge =  newCharge + s.netDedutable + s.copayValue;
        physician.cost['price'] = newCharge;
    });
  }
 
  return {
    makeFav: makeFav,
    refresh: refresh,
    all: physicians,
    updatePrice: updatePrice,
    highPrice: highPrice
  };
})

function conditionController($scope, $http, Procedure,City, Physician) {
  $scope.cities = City.all;
  $scope.add = function() {    
    if($scope.newProcedure !== undefined){
    
      $("#procedure-btn").html("Added succesfully!")
      
      setTimeout(function() {
        $("#procedure-btn").html("Add procedure")
      },4000);
    

      Procedure.add($scope.newProcedure);
    
      setTimeout(function() {

        Procedure.filter($scope.cities,-1);
        $("[data-toggle=tooltip]").tooltip();
        if (Procedure.all.length == 1)
          Physician.myphyPro = Procedure.all[0]

        if (Physician.all.length == 0) 
          Physician.refresh($scope.newProcedure)

      }, 500);

      $("#medicalCondition").tokenInput("clear");
    }
  }
}

function procedureController($scope, $http, Procedure, City, Physician) {
  $scope.procedures = Procedure.all;
  $scope.physicians = Physician.all;
  $scope.cities = City.all;
  $scope.list = 0;

  $scope.setListView = function(value){
    $scope.list = value;
    if(value == 0)
      $(".labs input:eq(0)").prop('checked','true');
    // drawMap();
  }

  $scope.destroy = function(index) {
    Procedure.destroy(index);
  }

  $scope.cityDestroy = function(index) {
    City.destroy(index);
    Procedure.removeCityCost(index, $scope);
    $("#previous-column").trigger('click');

  }

  $scope.filter = function(index){
    Procedure.filter($scope.cities,index);
  }

  $scope.emailShare = function(){
    Procedure.emailShare($scope.cities);
  }

}

function cityController($scope, $http, Procedure, City) {
  $scope.cities = City.all
  $scope.add = function() {
    var cityExists = false;
    $.map($scope.cities, function(c) {
      if (c.dataId == $scope.newLocationZip) 
        cityExists = true;
    });
    if(!cityExists) {
      City.add($scope.newLocation,$scope.newLocationZip,$scope.newLocationType,$scope.newLocationCategory,$scope.state);
      $("#next-column").trigger('click');
    }
    setTimeout(function(){
      $(".slider-range:last").slider('option', 'change')()
      $("[data-toggle=tooltip]").tooltip();
    },50);
    $scope.autoLocation = ''
    Procedure.filter($scope.cities,-1);
  }
}


function physicianController($scope, $http, City, Physician, Procedure) {

  $scope.physicians = Physician.all
  $scope.procedures = Procedure.all
  $scope.cities = City.all
  
  $scope.addProcedure = function(index){
    $("#token-input-medicalCondition").focus();
    $("html, body").animate({scrollTop:0}, '500', 'swing')
  }

  $scope.addLocation = function(index){
    $("#cityComplete").focus();
    $("#cityComplete").animate({
      width: "200"
    },500).animate({
      width: "160"
    },500).animate({
      width: "200"
    },500).animate({
      width: "160"
    },500);
  }

  $scope.flipGraph = function(index){
    $("#f"+index).toggleClass('hide');
    $("#b"+index).toggleClass('hide');
  }

  $scope.makeFav = function(id){
    Physician.makeFav(id,$scope.myphyPro);
  }

  $scope.updatePhysician = function(){
    // var location = $.trim($("#locationAdded option:selected").text());
    // Physician.refresh($scope.myphyPro, location);
    Physician.refresh($scope.myphyPro);
  }

  $scope.noPhysician = function(){
    // console.log($scope.physicians.length,$scope.cities.length,$scope.procedures.length);
    if($scope.procedures.length != 0 && $scope.cities.length != 0)
      return 1;
    else
      return 0;
  }

  $scope.filterPrice = function(){
    
  }

  $scope.sortPhysic = function(sortOn){
    if ($scope.column == '') {
      $scope.column = 'first_name'
      $scope.descending = false;
    }

    if ($scope.column == sortOn) {
        $scope.descending = !$scope.descending;
    } else {
        $scope.column = sortOn;
        $scope.descending = false;
    }
  }
}


function insuranceController($scope, Procedure, Physician){
  $scope.totalDeductible = "$0"
  $scope.deductiblePaid = "$0"
  $scope.copay = "$0"
  $scope.coInsurance = "0%"

  $scope.calculatePrice = function(){
    $scope.totalDeductibleValue = parseInt($scope.totalDeductible.substring(1))
    $scope.deductiblePaidValue = parseInt($scope.deductiblePaid.substring(1))
    $scope.coInsuranceValue = parseInt($scope.coInsurance.substring(0,$scope.coInsurance.length-1))
    $scope.copayValue = parseInt($scope.copay.substring(1))
    $scope.netDedutable = Math.abs($scope.totalDeductibleValue - $scope.deductiblePaidValue);
    $scope.netInsurance = 100 - $scope.coInsuranceValue;
    
    Procedure.calculatePrice($scope);
    Physician.updatePrice($scope);
  }
}
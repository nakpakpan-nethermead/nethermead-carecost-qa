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
    });
  }

  var calculatePrice = function(s){
    
    var totalDeductible = parseInt(s.totalDeductible.substring(1));
    var deductiblePaid = parseInt(s.deductiblePaid.substring(1));
    var coInsurance = parseInt(s.coInsurance.substring(0,s.coInsurance.length-1));
    var copay = parseInt(s.copay.substring(1));

    console.log(totalDeductible,deductiblePaid,coInsurance,copay);

    var netDedutable = Math.abs(totalDeductible - deductiblePaid);
    var netInsurance = 100 - coInsurance;

    console.log(netDedutable,netInsurance);

    for(i=0;i<procedures.length;i++) {
      $.each(procedures[i].charge , function(key,val){
        var newCharge = val.originalVal - netDedutable;
        newCharge = (newCharge * netInsurance)/100;
        newCharge =  newCharge + netDedutable + copay;
        procedures[i].charge[key]["val"] = newCharge;
      });
    }
  }

  return {
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

  var add = function(data,dataId,dataType,dataDisType) {
    var width = $("#costTable").width();
    var slider_width = $(".sliding-window").width();
    $("#costTable").width(width+175);
    $(".sliding-window").width(slider_width+175);
    var tmpCity = {}
    tmpCity["data"] = data;
    tmpCity["dataId"] = dataId;
    tmpCity["dataType"] = dataType;
    tmpCity["dataDisType"] = dataDisType;
    cities.push(tmpCity);
  }

  var destroy = function(index) {
    cities.splice(index-1,1);
    var slider_width = $(".sliding-window").width();
    var width = $("#costTable").width();
    $("#costTable").width(width-175);
    $(".sliding-window").width(slider_width-175);
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

  var refresh = function(fetch, $q) {
    
    physicians.splice(0,physicians.length);

    toSend['selectedPro'] = fetch;

    $http({
      url: '/provider/',
      method: 'GET',
      params: toSend
    }).success(function (response) {
      $.each(response, function(index, value){
        physicians.push(value);
      });
        // console.log(physicians);
        // var geocoder = new google.maps.Geocoder();
        // // { 'address': value.provider_address }, 
        // geocoder.geocode(
        //   { 'address': "Perundurai , Erode, India" }, 
        //   function (results, status) {
        //     if (status == google.maps.GeocoderStatus.OK) {
        //       var loc = results[0].geometry.location;
        //       value.locate = { 'lat': loc.lat(), 'lng': loc.lng() };
        //       physicians.push(value);
        //     }
        //   });
    });
  }

  var highPrice = function(){
    var highPrice = false;
    var high = 0;
    angular.forEach(physicians, function(physician, key) {
      if (physician.cost < high || highPrice === false) {
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
 
  return {
    makeFav: makeFav,
    refresh: refresh,
    all: physicians,
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

  // $scope.updatePhysician = function($event, procedureId){
  //   if($($event.target).prop('checked'))
  //     Physician.addProcedure(procedureId);
  //   else
  //     Physician.removeProcedure(procedureId);

  //   Physician.refresh();
  // }

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
      City.add($scope.newLocation,$scope.newLocationZip,$scope.newLocationType,$scope.newLocationCategory);
      $("#next-column").trigger('click');
    }
    $scope.autoLocation = ''
    Procedure.filter($scope.cities,-1);

  }
}


function physicianController($scope, $http, City, Physician, Procedure) {

  // Physician.refresh();
  // $scope.physician = Physician;
  // $scope.physicians = $scope.physician.all
  $scope.physicians = Physician.all
  $scope.procedures = Procedure.all
  $scope.cities = City.all
  
  $scope.flipGraph = function(index){
    $("#f"+index).toggleClass('hide');
    $("#b"+index).toggleClass('hide');
  }

  $scope.makeFav = function(id){
    Physician.makeFav(id,$scope.myphyPro);
  }

  $scope.updatePhysician = function(){
    Physician.refresh($scope.myphyPro);
  }

  $scope.noPhysician = function(){
    if($scope.physicians.length == 0 && $scope.procedures.length == 0)
      return 0;
    else
      return 1;
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


function insuranceController($scope, Procedure){
  $scope.totalDeductible = "$0"
  $scope.deductiblePaid = "$0"
  $scope.copay = "$0"
  $scope.coInsurance = "0%"
  $scope.calculatePrice = function(){
    Procedure.calculatePrice($scope);
  }
}
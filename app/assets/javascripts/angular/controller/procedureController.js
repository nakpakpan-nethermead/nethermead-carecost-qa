var myApp = angular.module('myApp',['AngularGM']);

myApp.service('Procedure',function($http){
  var procedures = [];

  var add = function(id) {
    $http.get('/procedure/price/'+id).success(function(response) {
      procedures.push(response);
    });
  }

  var destroy = function(index) {
      procedures.splice(index,1);
  }

  var removeCityCost = function(index) {
    for(i=0;i<procedures.length;i++) {
      // console.log(procedures[i].charge);
      procedures[i].charge.splice(index,1);
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

  return {
    add: add,
    destroy: destroy,
    removeCityCost: removeCityCost,
    filter: filter,
    all: procedures
  };
})

myApp.service('City',function($http){
  var cities = [];

  var add = function(data,dataType,dataDisType) {
    var width = $("#costTable").width();
    $("#costTable").width(width+200);
    var tmpCity = {}
    tmpCity["data"] = data;
    tmpCity["dataType"] = dataType;
    tmpCity["dataDisType"] = dataDisType;
    cities.push(tmpCity);
  }

  var destroy = function(index) {
    cities.splice(index-1,1);
    var width = $("#costTable").width();
    $("#costTable").width(width-200);
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
    });
  }

 
  return {
    refresh: refresh,
    all: physicians
  };
})

function conditionController($scope, $http, Procedure,City, Physician) {
  $scope.cities = City.all;
  $scope.add = function() {
    Procedure.add($scope.newProcedure);
    
    setTimeout(function() {
      Procedure.filter($scope.cities,-1);
      
      if (Procedure.all.length == 1)
        Physician.myphyPro = Procedure.all[0]

      if (Physician.all.length == 0) 
        Physician.refresh($scope.newProcedure)

    }, 500);

    $("#medicalCondition").val('');
  }
}

function procedureController($scope, $http, Procedure, City, Physician) {
  $scope.procedures = Procedure.all;
  $scope.physicians = Physician.all;
  $scope.cities = City.all;


  $scope.destroy = function(index) {
    Procedure.destroy(index);
  }

  $scope.cityDestroy = function(index) {
    City.destroy(index);
    Procedure.removeCityCost(index);
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
      if (c.data == $scope.newLocation && c.dataType == $scope.newLocationType) 
        cityExists = true;
    });
    if(!cityExists)
      City.add($scope.newLocation,$scope.newLocationType,$scope.newLocationCategory);
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
  
  $scope.flipGraph = function(index){
    $("#f"+index).toggleClass('hide');
    $("#b"+index).toggleClass('hide');
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
var myApp = angular.module('myApp',[]);

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
      console.log(procedures[i].charge);
      procedures[i].charge.splice(index,1);
    }
  }

  var filter = function(cities) {
    
    var toSend = {};
    toSend["procedures"] = [];
    toSend["procedures"].push(procedures);
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
      for(i=0;i<procedures.length;i++) {
        if(procedures[i].id == result[i].id){
          procedures[i] = result[i];
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
    // console.log(cities);
    $("#costTable th:last").scrollIntoView();
    $(window).scrollTop($('#myProDiv').offset().top);
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

function conditionController($scope, $http, Procedure) {
  $scope.add = function() {
    Procedure.add($scope.newProcedure);
    $("#medicalCondition").val('');
  }
}

function procedureController($scope, $http, Procedure, City) {
  $scope.procedures = Procedure.all;
  $scope.cities = City.all;

  $scope.destroy = function(index) {
    Procedure.destroy(index);
  }

  $scope.cityDestroy = function(index) {
    City.destroy(index);
    Procedure.removeCityCost(index);
  }

  $scope.filter = function(index){
    Procedure.filter($scope.cities);
  }

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
      City.add($scope.newLocation,$scope.newLocationType,$scope.autoLocation);
    $scope.autoLocation = ''
    Procedure.filter();
  }
}


function physicianController($scope, $http) {
  $scope.physicians = []
  $http.get('/provider/').success(function(response) {
    $scope.physicians = response;
  });

  $scope.flipGraph = function(index){
    $("#f"+index).toggleClass('hide');
    $("#b"+index).toggleClass('hide');
  }
}
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

  var filter = function(index) {
    
    var toSend = [];
    toSend['current_facility'] = procedures[index].current_facility;
    toSend['current_network'] = procedures[index].current_network;
    toSend['id'] = procedures[index].id;
    
    $http({
      url: '/procedure/price/'+procedures[index].id,
      method: 'GET',
      params: toSend
    }).success(function (result) {
      for(i=0;i<procedures.length;++i) {
        if(procedures[i].id == result.id){
          procedures[i] = result;
        }
      }
    });
  }

  return {
    add: add,
    destroy: destroy,
    filter: filter,
    all: procedures
  };
})

function conditionController($scope, $http, Procedure) {
  $scope.add = function() {
    Procedure.add($scope.newProcedure);
    $("#medicalCondition").val('');
  }
}

function procedureController($scope, $http, Procedure) {
  $scope.procedures = Procedure.all;
  $scope.destroy = function(index) {
    Procedure.destroy(index);
  }

  $scope.filter = function(index){
    Procedure.filter(index);
  } 
}

function cityController($scope, $http, Procedure) {
  $scope.cities = []
  $scope.add = function() {
    if($.inArray( $scope.newCity, $scope.cities ) == -1)
      $scope.cities.push($scope.newCity)
    
    


    $scope.newCity = ''
  }


}
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
      console.log(result);
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

  var refresh = function(fetch) {
    
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
      console.log(physicians);
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
      $('.selectpicker').selectpicker('refresh');
      if (Procedure.all.length == 1)
        $('.selectpicker').selectpicker('val', Procedure.all[0])

      Procedure.filter($scope.cities,-1);

    }, 500);

    $("#medicalCondition").val('');
    
    if (Physician.all.length == 0) 
      Physician.refresh();
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
}
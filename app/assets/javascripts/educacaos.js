$(document).ready(function () {

  form_id = $("form").attr("id");

if ($('body.educacaos_index').length) {



  console.log(form_id);


L.Icon.Default.imagePath = "/assets"

var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/{styleId}/256/{z}/{x}/{y}.png',
    cloudmadeAttribution = 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade';

var nightTime = L.tileLayer(cloudmadeUrl, {
        styleId:999
    });

var googleRoadMap = new L.Google('ROADMAP');
var googleSatellite = new L.Google('SATELLITE');

var limite = new L.TileLayer.WMS("http://geo.epdvr.com.br/geoserver/wms", {
            layers: 'nebulosa:limitevr_oficial',
            format: 'image/png',
            transparent: true
        });

var bairros = new L.TileLayer.WMS("http://geo.epdvr.com.br/geoserver/wms", {
            layers: 'nebulosa:bairros_novo',
            format: 'image/png',
            transparent: true
        });

var logradouros = new L.TileLayer.WMS("http://geo.epdvr.com.br/geoserver/wms", {
            layers: 'nebulosa:logradouros',
            format: 'image/png',
            transparent: true
        });

function onEducacaoFeature(feature, layer) {
  if (feature.properties && feature.properties.nome) {
      layer.bindPopup("<p><b>Nome:</b> "+feature.properties.nome+"</p>"+
                      "<p><b>Email:</b> "+feature.properties.email+"</p>");
      //console.log(feature.properties.nome);
  }
}

var educacao = new L.GeoJSON(null, {onEachFeature: onEducacaoFeature});
//console.log(educacao);

function educacaoJson(data) {
  educacao.addData(data);
}

$.ajax({
  url : "http://localhost:3000/educacional.json",
  success: educacaoJson
});

// create a map in the "map" div, set the view to a given place and zoom
var map = L.map('map', {drawControl: false, maxZoom: 25, minZoom: 13, layers: [limite, logradouros, googleSatellite ]}).setView([-22.511447, -44.108906], 13);


//****************  INICIANDO OS CONTROLES  *********************

var editarEdu = educacao;  //new L.FeatureGroup();
map.addLayer(editarEdu);


var options = {
    position: 'topleft',
    draw: {
        polyline: false,
        polygon: false,
        circle: false, // Turns off this drawing tool
        rectangle: false,

    },
    edit: {
        featureGroup: editarEdu, //REQUIRED!!
        remove: true
    }
};

var drawControl = new L.Control.Draw(options);
map.addControl(drawControl);

map.on('draw:created', function (e) {
    var type = e.layerType,
        layer = e.layer;
    var wkt = "POINT(" + layer.getLatLng().lng + " " + layer.getLatLng().lat + ")";


    $('#myModal').css({"z-index":"99999"});
    $('#map').css({"z-index":"0"});
    $('#myModal').modal('show');
    //console.log(form_id);

    $('#educacao_the_geom').val('');
    $('#educacao_the_geom').val(wkt);
    //layer.bindPopup('A popup!');
    editarEdu.addLayer(layer);

    $("#btnEduCancel").click( function()
           {
            editarEdu.removeLayer(layer);
           }
        );
});

map.on('draw:deleted', function (e) {
    var type = e.layerType,
        layer = e.layer;

    if (type === 'marker') {
        alert('Deletado!!');
    }

    editarEdu.addLayer(layer);
});



//*****************************************


var baseMaps = {
    //"Minimal": minimal,
    "Google": googleRoadMap,
    "Google Satélite": googleSatellite,
    "Noturno": nightTime

};

var overlayMaps = {
    "Limite Municipal": limite,
    "Bairros": bairros,
    //"Zoneamento": zoneamento,
    "Logradouros": logradouros,
    "Educação Municipal": educacao
    //"Lotes": lotes

};

L.control.layers(baseMaps, overlayMaps).addTo(map);

L.control.scale().addTo(map);

//}
}


//*****************************SUBMITED FORMS*********************************



$(document).bind('ajaxError', 'form#'+form_id, function(event, jqxhr, settings, exception){

    $(event.data).formErrors( $.parseJSON(jqxhr.responseText) );

  });



$('form').submit(function(event) {
    event.preventDefault();
    var valuesToSubmit = $(this).serialize();
    console.log($(this).attr('action'));
    console.log(valuesToSubmit);

    $.ajax({
        url: $(this).attr('action'), //sumbits it to the given url of the form
        data: valuesToSubmit,
        dataType: "JSON",
        type: "POST" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json){
        //alert('form#'+form_id);
        $('#myModal').modal('hide');
        $('#msg').remove();
        $('<div>').attr({ class: 'alert fade in alert-success', id: 'msg' }).html('Unidade Educacional salvo com sucesso').insertAfter( $('#cabecalho') ).fadeIn(200).show();
        $('#msg').fadeOut(5000);

    }).error(function(jqXHR, textStatus, errorThrown){
        console.log(textStatus + ' - ' + errorThrown);
    });

    return false; // prevents normal behaviour
});



  $('#myModal').on('hide.bs.modal', function (e) {
    $(this).clearErrors();
    $('.controls input').each(function(){
      $(this).val('');
    })
    $('#educacao_tipo option')[0].selected = true;
  });



  $.fn.formErrors = function(errors){

    $form = $(this);
    $(this).clearErrors();
    model = $(this).data('model');//'educacao';
    acao = $(this).attr('action');
    console.log(acao);

    $.each(errors, function(field, messages){
      $input = $('input[name="' + model + '[' + field + ']"]');
      $select = $('select[name="' + model + '[' + field + ']"]');
      //console.log($select);
      $input.closest('.control-group').addClass('error');
      $select.closest('.control-group').addClass('error');
      $('<spam>').attr({ class: 'help-inline' }).insertAfter( $('#'+model+'_'+field) ).html( messages.join(' & ') );
    });

    return false;

  };

  $.fn.clearErrors = function(){
    $('.control-group.error', this).each(function(){
      $('.help-inline', $(this)).html('');
      $(this).removeClass('error');
    });
  }

    $('.control-group.error', this).each(function(){
      $('.help-inline', $(this)).html('');
      $(this).removeClass('error');

    });

  });







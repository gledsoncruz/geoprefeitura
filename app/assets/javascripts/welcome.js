

L.Icon.Default.imagePath = "/assets"
//console.log(L.Icon.Default.imagePath);

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


var zoneamento = new L.TileLayer.WMS("http://geo.epdvr.com.br/geoserver/wms", {
            layers: 'nebulosa:zonas',
            format: 'image/png',
            transparent: true
        });

var logradouros = new L.TileLayer.WMS("http://geo.epdvr.com.br/geoserver/wms", {
            layers: 'nebulosa:logradouros',
            format: 'image/png',
            transparent: true
        });

//*****************************************

function onEducacaoFeature(feature, layer) {
  if (feature.properties && feature.properties.nome) {
      layer.bindPopup("<p><b>Nome:</b> "+feature.properties.nome+"</p>");
  }
}

var educacao = new L.GeoJSON(null, {onEachFeature: onEducacaoFeature});
//console.log(educacao);

function educacaoJson(data) {
  educacao.addData(data);
}

$.ajax({
  url : "http://geo.epdvr.com.br/geoserver/local/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=local:educacaos&outputFormat=json&format_options=callback:getJson",
  dataType : 'jsonp',
  jsonpCallback: 'getJson',
  success: educacaoJson
});

//*****************************************



// create a map in the "map" div, set the view to a given place and zoom
var map = L.map('map', {drawControl: false, maxZoom: 25, minZoom: 13, layers: [limite, logradouros, googleSatellite ]}).setView([-22.511447, -44.108906], 13);



var baseMaps = {
    //"Minimal": minimal,
    "Google": googleRoadMap,
    "Google Satélite": googleSatellite,
    "Noturno": nightTime

};

var overlayMaps = {
    "Limite Municipal": limite,
    "Bairros": bairros,
    "Zoneamento": zoneamento,
    "Logradouros": logradouros,
    "Educação Municipal": educacao
    //"Lotes": lotes

};

L.control.layers(baseMaps, overlayMaps).addTo(map);

L.control.scale().addTo(map);




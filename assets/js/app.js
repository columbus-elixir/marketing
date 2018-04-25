// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import "jquery"
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(document).ready(function(){
  $("#speakingRequestTab").hide();
  $("#userManagementButton").click(function(){
    $("#userManagementTab").show();
    $("#speakingRequestTab").hide();
    $("#approvedRequestsTab").hide();
  })
  $("#speakingRequestButton").click(function(){
    $("#speakingRequestTab").show();
    $("#userManagementTab").hide();
    $("#approvedRequestsTab").hide();
  })
  $("#approvedRequestsButton").click(function(){
    $("#speakingRequestTab").hide();
    $("#userManagementTab").hide();
    $("#approvedRequestsTab").show();
  })
})
$(document).ready(function(){
  $("#yourSpeakingRequestsTab").hide();
  $("#yourProfileButton").click(function(){
    $("#yourProfileTab").show();
    $("#yourSpeakingRequestsTab").hide();
  })
  $("#yourSpeakingRequestsButton").click(function(){
    $("#yourProfileTab").hide();
    $("#yourSpeakingRequestsTab").show();
  })
})

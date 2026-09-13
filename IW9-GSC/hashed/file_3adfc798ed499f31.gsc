/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3adfc798ed499f31.gsc
***********************************************/

_id_9A3C64059E71FA7B() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Covernode Screenshots\" \"set scr_start_debug screenshot\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_BB0CA5B4F194444A() {
  level endon("game_ended");

  if(scripts\engine\utility::flag("level_ready_for_script")) {
    wait 1;
    nodes = getallnodes();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(nodes[_id_AC0E594AC96AA3A8].type) && _id_064AA73047772B50(nodes[_id_AC0E594AC96AA3A8].type)) {
        _id_7CB4DDB9B507C769(nodes[_id_AC0E594AC96AA3A8]);
        _id_898A98F54B8E41C2();
      }
    }
  }
}

_id_064AA73047772B50(type) {
  switch (type) {
    case "End":
    case "Exposed":
    case "Path":
    case "Begin":
      return 0;
    default:
      return 1;
  }
}

_id_7CB4DDB9B507C769(node) {
  level endon("game_ended");
  level notify("move_player_to_node");
  level endon("move_player_to_node");
  _id_7AE510CEC9CB4A40 = -1 * anglesToForward(node.angles) * 64;
  level.players[0] dontinterpolate();
  level.players[0] setOrigin(node.origin + _id_7AE510CEC9CB4A40, 1);
  level.players[0] setplayerangles(node.angles);
  wait(getdvarfloat("dvar_F6B46E472C59D40C", 0.2));
}

_id_898A98F54B8E41C2() {
  level endon("game_ended");
  level notify("take_screenshot_of_node");
  level endon("take_screenshot_of_node");
}
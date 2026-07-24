/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3807.gsc
**************************************/

#using_animtree("script_model");

_id_E38C() {
  level _id_0EFB::_id_E3F7();
  level._id_E35D._id_47D9 = getEnt("hangar_crane", "targetname");
  level._id_E35D._id_47D9 _meth_83D0(#animtree);
  level._id_E35D._id_47D9 _meth_82A2(%crane_hangar_large_02_up, 1, 0);
  level._id_E35D._id_47D9.start = _id_0EFB::_id_7CBE("hangar_crane_pos", "targetname", "start");
  level._id_E35D._id_47D9.end = _id_0EFB::_id_7CBE("hangar_crane_pos", "targetname", "end");
  level._id_E35D._id_47D9._id_12BB7 = _id_0EFB::_id_7CBE("hangar_crane_pos", "targetname", "unload");
  level._id_E35D._id_47DC = _id_0EFB::_id_798A("hangar_crane_basket", "script_noteworthy", "basket");
  level._id_E35D._id_47DC._id_EF68 = _id_0EFB::_id_798A("hangar_crane_basket", "script_noteworthy", "scripted_node");
  level._id_E35D._id_47DC._id_EF68 linkTo(level._id_E35D._id_47DC);
  level._id_E35D._id_47DC _meth_83D0(#animtree);
  level._id_E35D._id_47DC _meth_82A2(%jackal_loading_platform_closed, 1, 0);
  level._id_E35D._id_47DC.lights = _id_0EFB::_id_7991("hangar_crane_basket", "script_noteworthy", "light");
  scripts\engine\utility::array_call(level._id_E35D._id_47DC.lights, ::linkto, level._id_E35D._id_47DC);
  level._id_E35D._id_47DC.origin = level._id_E35D._id_47D9 gettagorigin("tag_hook");
  level._id_E35D._id_47DC linkTo(level._id_E35D._id_47D9, "tag_hook");
  level._id_E35D._id_47D9.origin = level._id_E35D._id_47D9.start.origin;
  var_0 = getnumparts(level._id_E35D._id_47DC.model);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = getpartname(level._id_E35D._id_47DC.model, var_1);

    if(getsubstr(var_2, 0, 9) == "tag_light") {
      scripts\engine\utility::noself_delaycall(randomfloatrange(0, 0.3), ::playfxontag, scripts\engine\utility::getfx("red_light"), level._id_E35D._id_47DC, var_2);
    }
  }
}

_id_E38E(var_0, var_1) {
  level._id_E35D._id_47D9 endon("death");

  switch (var_0) {
    case "start":
      level._id_E35D._id_47D9 playSound("ship_titan_lg_crane_start");
      level._id_E35D._id_47D9 playLoopSound("ship_titan_lg_crane_loop");
      level._id_E35D._id_47D9 moveTo(level._id_E35D._id_47D9.start.origin, var_1);
      level._id_E35D._id_47D9 thread _id_E38F(var_1, "ship_titan_lg_crane_stop");
      break;
    case "end":
      level._id_E35D._id_47D9 playSound("ship_titan_lg_crane_start");
      level._id_E35D._id_47D9 playLoopSound("ship_titan_lg_crane_loop");
      level._id_E35D._id_47D9 moveTo(level._id_E35D._id_47D9.end.origin, var_1);
      level._id_E35D._id_47D9 thread _id_E38F(var_1, "ship_titan_lg_crane_stop");
      break;
    case "unload":
      level._id_E35D._id_47D9 playSound("ship_titan_lg_crane_start");
      level._id_E35D._id_47D9 playLoopSound("ship_titan_lg_crane_loop");
      level._id_E35D._id_47D9 moveTo(level._id_E35D._id_47D9._id_12BB7.origin, var_1);
      level._id_E35D._id_47D9 thread _id_E38F(var_1, "ship_titan_lg_crane_stop");
      break;
    case "up":
      level._id_E35D._id_47D9 playSound("ship_lg_crane_lift_start");
      level._id_E35D._id_47D9 playLoopSound("ship_lg_crane_lift_lp");
      level._id_E35D._id_47D9 setanimknob(%crane_hangar_large_02_up, 1, var_1);
      level._id_E35D._id_47D9 thread _id_E38F(var_1, "ship_lg_crane_lift_stop");
      break;
    case "down":
      level._id_E35D._id_47D9 playSound("ship_lg_crane_lift_start");
      level._id_E35D._id_47D9 playLoopSound("ship_lg_crane_lift_lp");
      level._id_E35D._id_47D9 setanimknob(%crane_hangar_large_02_down, 1, var_1);
      level._id_E35D._id_47D9 thread _id_E38F(var_1, "ship_lg_crane_lift_stop");
      break;
    case "basket_open":
      level._id_E35D._id_47DC setanimknob(%jackal_loading_platform_open, 1, var_1);
      break;
    case "basket_open_unload":
      level._id_E35D._id_47DC setanimknob(%jackal_loading_platform_open_unload, 1, var_1);
      break;
    case "basket_closed":
      level._id_E35D._id_47DC setanimknob(%jackal_loading_platform_closed, 1, var_1);
      break;
  }

  wait(var_1);
}

_id_E38F(var_0, var_1) {
  self endon("death");
  level endon("dropship_crane_stop");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  wait(var_0);
  self playSound(var_1);
  self stoploopsound();
}

_id_E390() {
  level._id_E35D._id_47D9 endon("death");
  level._id_E35D._id_47DC endon("death");

  for(;;) {
    _id_E38E("down", 3);
    _id_E38E("basket_open", 2);
    wait 2;
    level thread _id_E38E("basket_closed", 2);
    _id_E38E("up", 3);
    wait 2;
    _id_E38E("unload", 15);
    _id_E38E("basket_open_unload", 2);
    wait 2;
    _id_E38E("basket_closed", 2);
    _id_E38E("start", 15);
    scripts\engine\utility::waitframe();
  }
}
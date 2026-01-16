/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_createfx.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_createFxMenu;

createfx() {
  level._createfx_start_time = int(GetTime());
  level._createfx_time_saved = 0;
  precacheModel("fx_axis_createfx");
  precacheShader("black");
  if(GetDvar("createfx_scaleid") == "") {
    SetDvar("createfx_scaleid", "1");
  }
  if(GetDvar("createfx_drawaxis") == "") {
    SetDvar("createfx_drawaxis", "1");
  }
  if(GetDvar("createfx_drawaxis_range") == "") {
    SetDvar("createfx_drawaxis_range", "2000");
  }
  if(GetDvar("createfx_autosave_time") == "") {
    SetDvar("createfx_autosave_time", "600");
  }
  flag_init("createfx_saving");
  if(!isDefined(level.createFX))
    level.createFX = [];
  triggers = getentarray("trigger_multiple", "classname");
  for (i = 0; i < triggers.size; i++)
    triggers[i] delete();
  triggers = getentarray("trigger_radius", "classname");
  for (i = 0; i < triggers.size; i++)
    triggers[i] delete();
  level.callbackStartGameType = ::void;
  level.callbackPlayerDisconnect = ::void;
  level.callbackPlayerDamage = ::void;
  level.callbackPlayerKilled = ::void;
  level.callbackPlayerConnect = ::Callback_PlayerConnect;
  while (!isDefined(level.player))
    wait .05;
  thread createFxLogic();
  level waittill("eternity");
}

fx_init() {
  level.exploderFunction = maps\mp\_utility::exploder_before_load;
  waittillframeend;
  waittillframeend;
  level.exploderFunction = maps\mp\_utility::exploder_after_load;
  for (i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    ent set_forward_and_up_vectors();
    if(level.clientscripts) {
      if(!level.createFX_enabled) {
        continue;
      }
    }
    if(ent.v["type"] == "loopfx")
      ent thread maps\mp\_fx::loopfxthread();
    if(ent.v["type"] == "oneshotfx")
      ent thread maps\mp\_fx::oneshotfxthread();
    if(ent.v["type"] == "soundfx")
      ent thread maps\mp\_fx::create_loopsound();
  }
}

add_effect(name, effect) {
  if(!isDefined(level._effect))
    level._effect = [];
  level._effect[name] = loadfx(effect);
}

createEffect(type, fxid) {
  ent = spawnStruct();
  if(!isDefined(level.createFXent))
    level.createFXent = [];
  level.createFXent[level.createFXent.size] = ent;
  ent.v = [];
  ent.v["type"] = type;
  ent.v["fxid"] = fxid;
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.drawn = true;
  return ent;
}

createLoopSound() {
  ent = spawnStruct();
  if(!isDefined(level.createFXent))
    level.createFXent = [];
  level.createFXent[level.createFXent.size] = ent;
  ent.v = [];
  ent.v["type"] = "soundfx";
  ent.v["fxid"] = "No FX";
  ent.v["soundalias"] = "nil";
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.drawn = true;
  return ent;
}

createNewExploder() {
  ent = spawnStruct();
  if(!isDefined(level.createFXent))
    level.createFXent = [];
  level.createFXent[level.createFXent.size] = ent;
  ent.v = [];
  ent.v["type"] = "exploder";
  ent.v["fxid"] = "No FX";
  ent.v["soundalias"] = "nil";
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.v["exploder"] = 1;
  ent.v["exploder_type"] = "normal";
  ent.drawn = true;
  return ent;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglestoforward(self.v["angles"]);
}

createFxLogic() {
  waittillframeend;
  setMapCenter((0, 0, 0));
  menu_init();
  if(!isDefined(level._effect))
    level._effect = [];
  if(getdvar("createfx_map") == "")
    setdvar("createfx_map", level.script);
  else
  if(getdvar("createfx_map") == level.script) {}
  level.createFxHudElements = [];
  level.createFx_hudElements = 30;
  strOffsetX = [];
  strOffsetY = [];
  strOffsetX[0] = 0;
  strOffsetY[0] = 0;
  strOffsetX[1] = 1;
  strOffsetY[1] = 1;
  strOffsetX[2] = -2;
  strOffsetY[2] = 1;
  strOffsetX[3] = 1;
  strOffsetY[3] = -1;
  strOffsetX[4] = -2;
  strOffsetY[4] = -1;
  setdvar("fx", "nil");
  crossHair = newdebugHudElem();
  crossHair.location = 0;
  crossHair.alignX = "center";
  crossHair.alignY = "middle";
  crossHair.foreground = 1;
  crossHair.fontScale = 2;
  crossHair.sort = 20;
  crossHair.alpha = 1;
  crossHair.x = 320;
  crossHair.y = 233;
  crossHair setText(".");
  level.clearTextMarker = newdebugHudElem();
  level.clearTextMarker.alpha = 0;
  level.clearTextMarker setText("marker");
  for (i = 0; i < level.createFx_hudElements; i++) {
    newStrArray = [];
    for (p = 0; p < 2; p++) {
      newStr = newdebugHudElem();
      newStr.alignX = "left";
      newStr.location = 0;
      newStr.foreground = 1;
      newStr.fontScale = 1.30;
      newStr.sort = 20 - p;
      newStr.alpha = 1;
      newStr.x = 0 + strOffsetX[p];
      newStr.y = 60 + strOffsetY[p] + i * 15;
      if(p > 0)
        newStr.color = (0, 0, 0);
      newStrArray[newStrArray.size] = newStr;
    }
    level.createFxHudElements[i] = newStrArray;
  }
  newStrArray = [];
  for (p = 0; p < 2; p++) {
    newStr = newdebugHudElem();
    newStr.alignX = "center";
    newStr.location = 0;
    newStr.foreground = 1;
    newStr.fontScale = 1.30;
    newStr.sort = 20 - p;
    newStr.alpha = 1;
    newStr.x = 320 + strOffsetX[p];
    newStr.y = 80 + strOffsetY[p];
    if(p > 0)
      newStr.color = (0, 0, 0);
    newStrArray[newStrArray.size] = newStr;
  }
  level.createFX_centerPrint = newStrArray;
  level.selectedMove_up = 0;
  level.selectedMove_forward = 0;
  level.selectedMove_right = 0;
  level.selectedRotate_pitch = 0;
  level.selectedRotate_roll = 0;
  level.selectedRotate_yaw = 0;
  level.selected_fx = [];
  level.selected_fx_ents = [];
  level.createfx_lockedList = [];
  level.createfx_lockedList["escape"] = true;
  level.createfx_lockedList["BUTTON_LSHLDR"] = true;
  level.createfx_lockedList["BUTTON_RSHLDR"] = true;
  level.createfx_lockedList["mouse1"] = true;
  level.createfx_lockedList["ctrl"] = true;
  level.createfx_draw_enabled = true;
  level.buttonIsHeld = [];
  axisMode = false;
  colors = [];
  colors["loopfx"]["selected"] = (1.0, 1.0, 0.2);
  colors["loopfx"]["highlighted"] = (0.4, 0.95, 1.0);
  colors["loopfx"]["default"] = (0.3, 0.8, 1.0);
  colors["oneshotfx"]["selected"] = (1.0, 1.0, 0.2);
  colors["oneshotfx"]["highlighted"] = (0.4, 0.95, 1.0);
  colors["oneshotfx"]["default"] = (0.3, 0.8, 1.0);
  colors["exploder"]["selected"] = (1.0, 1.0, 0.2);
  colors["exploder"]["highlighted"] = (1.0, 0.2, 0.2);
  colors["exploder"]["default"] = (1.0, 0.1, 0.1);
  colors["rainfx"]["selected"] = (1.0, 1.0, 0.2);
  colors["rainfx"]["highlighted"] = (.95, 0.4, 0.95);
  colors["rainfx"]["default"] = (.78, 0.0, 0.73);
  colors["soundfx"]["selected"] = (1.0, 1.0, 0.2);
  colors["soundfx"]["highlighted"] = (.5, 1.0, 0.75);
  colors["soundfx"]["default"] = (.2, 0.9, 0.2);
  lastHighlightedEnt = undefined;
  level.fx_rotating = false;
  setMenu("none");
  level.createfx_selecting = false;
  black = newdebugHudElem();
  black.x = -120;
  black.y = 200;
  black.foreground = 0;
  black setShader("black", 250, 160);
  black.alpha = 0;
  level.createfx_inputlocked = false;
  for (i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    ent post_entity_creation_function();
  }
  thread draw_distance();
  lastSelectEntity = undefined;
  thread createfx_autosave();
  for (;;) {
    changedSelectedEnts = false;
    right = anglestoright(level.player getplayerangles());
    forward = anglestoforward(level.player getplayerangles());
    up = anglestoup(level.player getplayerangles());
    dot = 0.85;
    placeEnt_vector = vectorScale(forward, 750);
    level.createfxCursor = bullettrace(level.player geteye(), level.player geteye() + placeEnt_vector, false, undefined);
    highlightedEnt = undefined;
    /
  } else {
    stop_drawing_axis_models();
    selectedMove_vector = get_selected_move_vector();
    for (i = 0; i < level.selected_fx_ents.size; i++) {
      ent = level.selected_fx_ents[i];
      if(isDefined(ent.model)) {
        continue;
      }
      ent.v["origin"] = ent.v["origin"] + selectedMove_vector;
    }
    if(distance((0, 0, 0), selectedMove_vector) > 0)
      changedSelectedEnts = true;
    wait(0.05);
  }
  if(changedSelectedEnts)
    update_selected_entities();
  lastHighlightedEnt = highlightedEnt;
  if(last_selected_entity_has_changed(lastSelectEntity)) {
    level.effect_list_offset = 0;
    clear_settable_fx();
    setmenu("none");
  }
  if(level.selected_fx_ents.size)
    lastSelectEntity = level.selected_fx_ents[level.selected_fx_ents.size - 1];
  else
    lastSelectEntity = undefined;
}

}

toggle_createfx_drawing() {
  level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

manipulate_createfx_ents(highlightedEnt, leftClick, leftHeld, ctrlHeld, colors, right) {
  if(!level.createfx_draw_enabled) {
    return;
  }
  for (i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!ent.drawn) {
      continue;
    }
    scale = getdvarfloat("createfx_scaleid");
    if(isDefined(highlightedEnt) && ent == highlightedEnt) {
      if(!entities_are_selected())
        display_fx_info(ent);
      if(leftClick) {
        entWasSelected = index_is_selected(i);
        level.createfx_selecting = !entWasSelected;
        if(!ctrlHeld) {
          selectedSize = level.selected_fx_ents.size;
          clear_entity_selection();
          if(entWasSelected && selectedSize == 1)
            select_entity(i, ent);
        }
        toggle_entity_selection(i, ent);
      } else
      if(leftHeld) {
        if(ctrlHeld) {
          if(level.createfx_selecting)
            select_entity(i, ent);
          if(!level.createfx_selecting)
            deselect_entity(i, ent);
        }
      }
      colorIndex = "highlighted";
      if(index_is_selected(i))
        colorIndex = "selected";
      print3d(ent.v["origin"], ".", colors[ent.v["type"]][colorIndex], 1, scale);
      if(ent.textalpha > 0) {
        printRight = vectorScale(right, ent.v["fxid"].size * -2.93 * scale);
        print3d(ent.v["origin"] + printRight + (0, 0, 15), ent.v["fxid"], colors[ent.v["type"]][colorIndex], ent.textalpha, scale);
      }
    } else {
      colorIndex = "default";
      if(index_is_selected(i))
        colorIndex = "selected";
      print3d(ent.v["origin"], ".", colors[ent.v["type"]][colorIndex], 1, scale);
      if(ent.textalpha > 0) {
        printRight = vectorScale(right, ent.v["fxid"].size * -2.93);
        print3d(ent.v["origin"] + printRight + (0, 0, 15), ent.v["fxid"], colors[ent.v["type"]][colorIndex], ent.textalpha, scale);
      }
    }
  }
}

clear_settable_fx() {
  level.createfx_inputlocked = false;
  setdvar("fx", "nil");
  level.selected_fx_option_index = undefined;
  reset_fx_hud_colors();
}

reset_fx_hud_colors() {
  for (i = 0; i < level.createFx_hudElements; i++)
    level.createFxHudElements[i][0].color = (1, 1, 1);
}

button_is_held(name, name2) {
  if(isDefined(name2)) {
    if(isDefined(level.buttonIsHeld[name2]))
      return true;
  }
  return isDefined(level.buttonIsHeld[name]);
}

button_is_clicked(name, name2) {
  if(isDefined(name2)) {
    if(isDefined(level.buttonClick[name2]))
      return true;
  }
  return isDefined(level.buttonClick[name]);
}

toggle_entity_selection(index, ent) {
  if(isDefined(level.selected_fx[index]))
    deselect_entity(index, ent);
  else
    select_entity(index, ent);
}

select_entity(index, ent) {
  if(isDefined(level.selected_fx[index]))
    return;
  clear_settable_fx();
  level notify("new_ent_selection");
  ent thread entity_highlight_enable();
  level.selected_fx[index] = true;
  level.selected_fx_ents[level.selected_fx_ents.size] = ent;
}

ent_is_highlighted(ent) {
  if(!isDefined(level.fx_highLightedEnt))
    return false;
  return ent == level.fx_highLightedEnt;
}

deselect_entity(index, ent) {
  if(!isDefined(level.selected_fx[index])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  level.selected_fx[index] = undefined;
  if(!ent_is_highlighted(ent))
    ent thread entity_highlight_disable();
  newArray = [];
  for (i = 0; i < level.selected_fx_ents.size; i++) {
    if(level.selected_fx_ents[i] != ent)
      newArray[newArray.size] = level.selected_fx_ents[i];
  }
  level.selected_fx_ents = newArray;
}

index_is_selected(index) {
  return isDefined(level.selected_fx[index]);
}

ent_is_selected(ent) {
  for (i = 0; i < level.selected_fx_ents.size; i++) {
    if(level.selected_fx_ents[i] == ent)
      return true;
  }
  return false;
}

clear_entity_selection() {
  for (i = 0; i < level.selected_fx_ents.size; i++) {
    if(!ent_is_highlighted(level.selected_fx_ents[i]))
      level.selected_fx_ents[i] thread entity_highlight_disable();
  }
  level.selected_fx = [];
  level.selected_fx_ents = [];
}

draw_axis() {
  if(GetDvarInt("createfx_drawaxis") != 1) {
    return;
  }
  if(isDefined(self.draw_axis_model)) {
    return;
  }
  self.draw_axis_model = Spawn("script_model", self.v["origin"]);
  self.draw_axis_model SetModel("fx_axis_createfx");
  level thread draw_axis_think(self);
  if(!isDefined(level.draw_axis_models)) {
    level.draw_axis_models = [];
  }
  level.draw_axis_models[level.draw_axis_models.size] = self.draw_axis_model;
}

draw_axis_think(axis_parent) {
  axis_model = axis_parent.draw_axis_model;
  while (1) {
    if(!isDefined(axis_parent)) {
      break;
    }
    if(!isDefined(axis_model)) {
      break;
    }
    axis_parent.draw_axis_model.origin = axis_parent.v["origin"];
    axis_parent.draw_axis_model.angles = axis_parent.v["angles"];
    wait(0.05);
  }
  if(isDefined(axis_model)) {
    axis_model Delete();
  }
}

stop_drawing_axis_models() {
  if(isDefined(level.draw_axis_models)) {
    for (i = 0; i < level.draw_axis_models.size; i++) {
      if(isDefined(level.draw_axis_models[i])) {
        level.draw_axis_models[i] Delete();
      }
    }
  }
}

clear_fx_hudElements() {
  level.clearTextMarker clearAllTextAfterHudElem();
  for (i = 0; i < level.createFx_hudElements; i++) {
    for (p = 0; p < 2; p++)
      level.createFxHudElements[i][p] setText("");
  }
  level.fxHudElements = 0;
}

set_fx_hudElement(text) {
  for (p = 0; p < 2; p++)
    level.createFxHudElements[level.fxHudElements][p] setText(text);
  level.fxHudElements++;
  assert(level.fxHudElements < level.createFx_hudElements);
}

createfx_centerprint(text) {
  thread createfx_centerprint_thread(text);
}

createfx_centerprint_thread(text) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");
  for (p = 0; p < 2; p++)
    level.createFX_centerPrint[p] setText(text);
  wait(4.5);
  for (p = 0; p < 2; p++)
    level.createFX_centerPrint[p] setText("");
}

buttonDown(button, button2) {
  return buttonPressed_internal(button) || buttonPressed_internal(button2);
}

buttonPressed_internal(button) {
  if(!isDefined(button))
    return false;
  if(kb_locked(button))
    return false;
  return level.player buttonPressed(button);
}

get_selected_move_vector() {
  yaw = level.player getplayerangles()[1];
  angles = (0, yaw, 0);
  right = anglestoright(angles);
  forward = anglestoforward(angles);
  up = anglestoup(angles);
  keypressed = false;
  rate = 1;
  if(buttonDown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedMove_forward < 0)
      level.selectedMove_forward = 0;
    level.selectedMove_forward = level.selectedMove_forward + rate;
  } else
  if(buttonDown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedMove_forward > 0)
      level.selectedMove_forward = 0;
    level.selectedMove_forward = level.selectedMove_forward - rate;
  } else
    level.selectedMove_forward = 0;
  if(buttonDown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedMove_right < 0)
      level.selectedMove_right = 0;
    level.selectedMove_right = level.selectedMove_right + rate;
  } else
  if(buttonDown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedMove_right > 0)
      level.selectedMove_right = 0;
    level.selectedMove_right = level.selectedMove_right - rate;
  } else
    level.selectedMove_right = 0;
  if(buttonDown("BUTTON_Y")) {
    if(level.selectedMove_up < 0)
      level.selectedMove_up = 0;
    level.selectedMove_up = level.selectedMove_up + rate;
  } else
  if(buttonDown("BUTTON_B")) {
    if(level.selectedMove_up > 0)
      level.selectedMove_up = 0;
    level.selectedMove_up = level.selectedMove_up - rate;
  } else
    level.selectedMove_up = 0;
  vector = (0, 0, 0);
  vector += vectorScale(forward, level.selectedMove_forward);
  vector += vectorScale(right, level.selectedMove_right);
  vector += vectorScale(up, level.selectedMove_up);
  if(vector != (0, 0, 0))
    println("Moved vec : " + vector);
  return vector;
}

process_button_held_and_clicked() {
  add_button("mouse1");
  add_kb_button("shift");
  add_kb_button("ctrl");
  add_button("BUTTON_RSHLDR");
  add_button("BUTTON_LSHLDR");
  add_button("BUTTON_RSTICK");
  add_button("BUTTON_LSTICK");
  add_button("BUTTON_A");
  add_button("BUTTON_B");
  add_button("BUTTON_X");
  add_button("BUTTON_Y");
  add_button("DPAD_UP");
  add_button("DPAD_LEFT");
  add_button("DPAD_RIGHT");
  add_button("DPAD_DOWN");
  add_kb_button("escape");
  add_button("BUTTON_RTRIG");
  add_button("BUTTON_LTRIG");
  add_kb_button("a");
  add_button("F1");
  add_button("F5");
  add_button("F2");
  add_kb_button("c");
  add_kb_button("h");
  add_kb_button("i");
  add_kb_button("k");
  add_kb_button("l");
  add_kb_button("m");
  add_kb_button("p");
  add_kb_button("x");
  add_button("del");
  add_kb_button("end");
  add_kb_button("tab");
  add_kb_button("ins");
  add_kb_button("add");
  add_kb_button("space");
  add_kb_button("enter");
  add_kb_button("v");
  add_kb_button("1");
  add_kb_button("2");
  add_kb_button("3");
  add_kb_button("4");
  add_kb_button("5");
  add_kb_button("6");
  add_kb_button("7");
  add_kb_button("8");
  add_kb_button("9");
  add_kb_button("0");
}

locked(name) {
  if(isDefined(level.createfx_lockedList[name]))
    return false;
  return kb_locked(name);
}

kb_locked(name) {
  return level.createfx_inputlocked && isDefined(level.button_is_kb[name]);
}

add_button(name) {
  if(locked(name)) {
    return;
  }
  if(!isDefined(level.buttonIsHeld[name])) {
    if(level.player buttonPressed(name)) {
      level.buttonIsHeld[name] = true;
      level.buttonClick[name] = true;
    }
  } else {
    if(!level.player buttonPressed(name)) {
      level.buttonIsHeld[name] = undefined;
    }
  }
}

add_kb_button(name) {
  level.button_is_kb[name] = true;
  add_button(name);
}

set_anglemod_move_vector() {
  rate = 1;
  if(buttonDown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedRotate_pitch < 0)
      level.selectedRotate_pitch = 0;
    level.selectedRotate_pitch = level.selectedRotate_pitch + rate;
  } else
  if(buttonDown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedRotate_pitch > 0)
      level.selectedRotate_pitch = 0;
    level.selectedRotate_pitch = level.selectedRotate_pitch - rate;
  } else
    level.selectedRotate_pitch = 0;
  if(buttonDown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedRotate_yaw < 0)
      level.selectedRotate_yaw = 0;
    level.selectedRotate_yaw = level.selectedRotate_yaw + rate;
  } else
  if(buttonDown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedRotate_yaw > 0)
      level.selectedRotate_yaw = 0;
    level.selectedRotate_yaw = level.selectedRotate_yaw - rate;
  } else
    level.selectedRotate_yaw = 0;
  if(buttonDown("BUTTON_Y")) {
    if(level.selectedRotate_roll < 0)
      level.selectedRotate_roll = 0;
    level.selectedRotate_roll = level.selectedRotate_roll + rate;
  } else
  if(buttonDown("BUTTON_B")) {
    if(level.selectedRotate_roll > 0)
      level.selectedRotate_roll = 0;
    level.selectedRotate_roll = level.selectedRotate_roll - rate;
  } else
    level.selectedRotate_roll = 0;
}

cfxprintln(file, string) {
  if(file == -1)
    return;
  fprintln(file, string);
}

generate_client_fx_log(autosave) {
    if(!autosave) {
      tab = " ";
      filename = "mpclientcreatefx/" + level.script + "_fx.csc";
      file = openfile(filename, "write");
      assertex(file != -1, "File not writeable (maybe you should check it out): " + filename);
      cfxprintln(file, "
        cfxprintln(file, "main()"); cfxprintln(file, "{"); println(" *** CREATING EFFECT, COPY THESE LINES TO ", level.script, "_fx.csc *** "); cfxprintln(file, "
          for (i = 0; i < level.createFXent.size; i++) {
            if(file != -1)
              wait .05;
            e = level.createFXent[i];
            assertEX(isDefined(e.v["type"]), "effect at origin " + e.v["origin"] + " has no type");
            if(isDefined(e.model))
              continue;
            if(e.v["type"] == "loopfx") {
              println("	ent = clientscripts\\mp\\_fx::createLoopEffect( \"" + e.v["fxid"] + "\" );");
              cfxprintln(file, tab + "	ent = clientscripts\\mp\\_fx::createLoopEffect( \"" + e.v["fxid"] + "\" );");
            }
            if(e.v["type"] == "oneshotfx") {
              println("	ent = clientscripts\\mp\\_fx::createOneshotEffect( \"" + e.v["fxid"] + "\" );");
              cfxprintln(file, tab + "	ent = clientscripts\\mp\\_fx::createOneshotEffect( \"" + e.v["fxid"] + "\" );");
            }
            if(e.v["type"] == "soundfx") {
              println("	ent = clientscripts\\mp\\_fx::createLoopSound();");
              cfxprintln(file, tab + "	ent = clientscripts\\mp\\_fx::createLoopSound();");
            }
            if(e.v["type"] != "exploder") {
              println("	ent.v[ \"origin\" ] = ( " + e.v["origin"][0] + ", " + e.v["origin"][1] + ", " + e.v["origin"][2] + " );");
              cfxprintln(file, tab + "	ent.v[ \"origin\" ] = ( " + e.v["origin"][0] + ", " + e.v["origin"][1] + ", " + e.v["origin"][2] + " );");
              println("	ent.v[ \"angles\" ] = ( " + e.v["angles"][0] + ", " + e.v["angles"][1] + ", " + e.v["angles"][2] + " );");
              cfxprintln(file, tab + "	ent.v[ \"angles\" ] = ( " + e.v["angles"][0] + ", " + e.v["angles"][1] + ", " + e.v["angles"][2] + " );");
              print_fx_options(e, tab, file, autosave);
            }
            println(" ");
            cfxprintln(file, " ");
          }
          if(level.bScriptgened) {
            script_gen_dump_addline("clientscripts\\mp\\createfx\\" + level.script + "_fx::main();", level.script + "_fx");
            maps\mp\_load::script_gen_dump();
          }
          cfxprintln(file, "}"); saved = closefile(file); assertex(saved == 1, "File not saved (see above message?): " + filename); flag_clear("createfx_saving"); println("CreateFX entities placed: " + level.createFxEnt.size);
        }
      }
      generate_fx_log(autosave) {

          flag_waitopen("createfx_saving");
          flag_set("createfx_saving");
          autosave = isDefined(autosave);
          tab = " ";
          filename = "mpcreatefx/" + level.script + "_fx.gsc";
          if(autosave)
            filename = "mpcreatefx/backup.gsc";
          file = openfile(filename, "write");
          assertex(file != -1, "File not writeable (maybe you should check it out): " + filename);
          cfxprintln(file, "
              cfxprintln(file, "main()"); cfxprintln(file, "{");
              if(!autosave)
                cfxprintln(file, "
                  limit = 0.1;
                  for (p = 0; p < level.createFXent.size; p++) {
                    ent = level.createFXent[p];
                    origin = [];
                    angles = [];
                    for (i = 0; i < 3; i++) {
                      origin[i] = ent.v["origin"][i];
                      angles[i] = ent.v["angles"][i];
                      if(origin[i] < limit && origin[i] > limit * -1)
                        origin[i] = 0;
                      if(angles[i] < limit && angles[i] > limit * -1)
                        angles[i] = 0;
                    }
                    ent.v["origin"] = (origin[0], origin[1], origin[2]);
                    ent.v["angles"] = (angles[0], angles[1], angles[2]);
                  }
                  if(!autosave)
                    println(" *** CREATING EFFECT, COPY THESE LINES TO ", level.script, "_fx.gsc *** ");
                  for (i = 0; i < level.createFXent.size; i++) {
                    if(file != -1)
                      wait .05;
                    e = level.createFXent[i];
                    assertEX(isDefined(e.v["type"]), "effect at origin " + e.v["origin"] + " has no type");
                    if(isDefined(e.model))
                      continue;
                    if(e.v["type"] == "loopfx") {
                      if(!autosave)
                        println("	ent = maps\\mp\\_utility::createLoopEffect( \"" + e.v["fxid"] + "\" );");
                      cfxprintln(file, tab + "	ent = maps\\mp\\_utility::createLoopEffect( \"" + e.v["fxid"] + "\" );");
                    }
                    if(e.v["type"] == "oneshotfx") {
                      if(!autosave)
                        println("	ent = maps\\mp\\_utility::createOneshotEffect( \"" + e.v["fxid"] + "\" );");
                      cfxprintln(file, tab + "	ent = maps\\mp\\_utility::createOneshotEffect( \"" + e.v["fxid"] + "\" );");
                    }
                    if(e.v["type"] == "exploder") {
                      if(!autosave)
                        println("	ent = maps\\mp\\_utility::createExploder( \"" + e.v["fxid"] + "\" );");
                      cfxprintln(file, tab + "	ent = maps\\mp\\_utility::createExploder( \"" + e.v["fxid"] + "\" );");
                    }
                    if(e.v["type"] == "soundfx") {
                      if(!autosave)
                        println("	ent = maps\\mp\\_createfx::createLoopSound();");
                      cfxprintln(file, tab + "	ent = maps\\mp\\_createfx::createLoopSound();");
                    }
                    if(autosave) {
                      fxprops = get_fx_options(e, tab);
                      cfxprintln(file, fxprops);
                    } else {
                      println("	ent.v[ \"origin\" ] = ( " + e.v["origin"][0] + ", " + e.v["origin"][1] + ", " + e.v["origin"][2] + " );");
                      println("	ent.v[ \"angles\" ] = ( " + e.v["angles"][0] + ", " + e.v["angles"][1] + ", " + e.v["angles"][2] + " );");
                      cfxprintln(file, tab + "	ent.v[ \"origin\" ] = ( " + e.v["origin"][0] + ", " + e.v["origin"][1] + ", " + e.v["origin"][2] + " );");
                      cfxprintln(file, tab + "	ent.v[ \"angles\" ] = ( " + e.v["angles"][0] + ", " + e.v["angles"][1] + ", " + e.v["angles"][2] + " );");
                      print_fx_options(e, tab, file, autosave);
                    }
                    if(!autosave)
                      println(" ");
                    cfxprintln(file, " ");
                  }
                  if(level.bScriptgened) {
                    script_gen_dump_addline("maps\\mp\\createfx\\" + level.script + "_fx::main();", level.script + "_fx");
                    maps\mp\_load::script_gen_dump();
                  }
                  cfxprintln(file, "}"); saved = closefile(file); assertex(saved == 1, "File not saved (see above message?): " + filename);
                  if(level.clientscripts) {
                    generate_client_fx_log(autosave);
                  }
                  flag_clear("createfx_saving"); println("CreateFX entities placed: " + level.createFxEnt.size);
                }
              print_fx_options(ent, tab, file, autosave) {
                for (i = 0; i < level.createFX_options.size; i++) {
                  option = level.createFX_options[i];
                  if(!isDefined(ent.v[option["name"]]))
                    continue;
                  if(!mask(option["mask"], ent.v["type"])) {
                    continue;
                  }
                  if(option["type"] == "string") {
                    if(!autosave)
                      println("	ent.v[ \"" + option["name"] + "\" ] = \"" + ent.v[option["name"]] + "\";");
                    cfxprintln(file, tab + "	ent.v[ \"" + option["name"] + "\" ] = \"" + ent.v[option["name"]] + "\";");
                    continue;
                  }
                  if(!autosave)
                    println("	ent.v[ \"" + option["name"] + "\" ] = " + ent.v[option["name"]] + ";");
                  cfxprintln(file, tab + "	ent.v[ \"" + option["name"] + "\" ] = " + ent.v[option["name"]] + ";");
                }
              }
              get_fx_options(ent, tab) {
                sprops = "";
                sprops += tab + "	ent.v[ \"origin\" ] = ( " + ent.v["origin"][0] + ", " + ent.v["origin"][1] + ", " + ent.v["origin"][2] + " );";
                sprops += tab + "	ent.v[ \"angles\" ] = ( " + ent.v["angles"][0] + ", " + ent.v["angles"][1] + ", " + ent.v["angles"][2] + " );";
                for (i = 0; i < level.createFX_options.size; i++) {
                  option = level.createFX_options[i];
                  quotes = "";
                  if(!isDefined(ent.v[option["name"]]))
                    continue;
                  if(!mask(option["mask"], ent.v["type"]))
                    continue;
                  if(option["type"] == "string")
                    quotes = "\"";
                  sprops += tab + "	ent.v[ \"" + option["name"] + "\" ] = " + quotes + ent.v[option["name"]] + quotes + ";";
                }
                return sprops;
              }
              entity_highlight_disable() {
                self notify("highlight change");
                self endon("highlight change");
                for (;;) {
                  self.textalpha = self.textalpha * 0.85;
                  self.textalpha = self.textalpha - 0.05;
                  if(self.textalpha < 0) {
                    break;
                  }
                  wait(0.05);
                }
                self.textalpha = 0;
              }
              entity_highlight_enable() {
                self notify("highlight change");
                self endon("highlight change");
                for (;;) {
                  self.textalpha = self.textalpha + 0.05;
                  self.textalpha = self.textalpha * 1.25;
                  if(self.textalpha > 1) {
                    break;
                  }
                  wait(0.05);
                }
                self.textalpha = 1;
              }
              get_center_of_array(array) {
                center = (0, 0, 0);
                for (i = 0; i < array.size; i++)
                  center = (center[0] + array[i].v["origin"][0], center[1] + array[i].v["origin"][1], center[2] + array[i].v["origin"][2]);
                return (center[0] / array.size, center[1] / array.size, center[2] / array.size);
              }
              ent_draw_axis() {
                self endon("death");
                for (;;) {
                  draw_axis();
                  wait(0.05);
                }
              }
              rotation_is_occuring() {
                if(level.selectedRotate_roll != 0)
                  return true;
                if(level.selectedRotate_pitch != 0)
                  return true;
                return level.selectedRotate_yaw != 0;
              }
              process_fx_rotater() {
                if(level.fx_rotating) {
                  return;
                }
                set_anglemod_move_vector();
                if(!rotation_is_occuring()) {
                  return;
                }
                level.fx_rotating = true;
                if(level.selected_fx_ents.size > 1) {
                  center = get_center_of_array(level.selected_fx_ents);
                  org = spawn("script_origin", center);
                  org.v["angles"] = level.selected_fx_ents[0].v["angles"];
                  org.v["origin"] = center;
                  rotater = [];
                  for (i = 0; i < level.selected_fx_ents.size; i++) {
                    rotater[i] = spawn("script_origin", level.selected_fx_ents[i].v["origin"]);
                    rotater[i].angles = level.selected_fx_ents[i].v["angles"];
                    rotater[i] linkto(org);
                  }
                  rotate_over_time(org, rotater);
                  org delete();
                  for (i = 0; i < rotater.size; i++)
                    rotater[i] delete();
                } else
                if(level.selected_fx_ents.size == 1) {
                  ent = level.selected_fx_ents[0];
                  rotater = spawn("script_origin", (0, 0, 0));
                  rotater.angles = ent.v["angles"];
                  if(level.selectedRotate_pitch != 0)
                    rotater devAddPitch(level.selectedRotate_pitch);
                  else
                  if(level.selectedRotate_yaw != 0)
                    rotater devAddYaw(level.selectedRotate_yaw);
                  else
                    rotater devAddRoll(level.selectedRotate_roll);
                  ent.v["angles"] = rotater.angles;
                  rotater delete();
                  wait(0.05);
                }
                level.fx_rotating = false;
              }
              rotate_over_time(org, rotater) {
                level endon("new_ent_selection");
                timer = 0.1;
                for (p = 0; p < timer * 20; p++) {
                  if(level.selectedRotate_pitch != 0)
                    org devAddPitch(level.selectedRotate_pitch);
                  else
                  if(level.selectedRotate_yaw != 0)
                    org devAddYaw(level.selectedRotate_yaw);
                  else
                    org devAddRoll(level.selectedRotate_roll);
                  wait(0.05);
                  for (i = 0; i < level.selected_fx_ents.size; i++) {
                    ent = level.selected_fx_ents[i];
                    if(isDefined(ent.model)) {
                      continue;
                    }
                    ent.v["origin"] = rotater[i].origin;
                    ent.v["angles"] = rotater[i].angles;
                  }
                }
              }
              delete_pressed() {
                if(level.createfx_inputlocked) {
                  remove_selected_option();
                  return;
                }
                delete_selection();
              }
              remove_selected_option() {
                if(!isDefined(level.selected_fx_option_index)) {
                  return;
                }
                name = level.createFX_options[level.selected_fx_option_index]["name"];
                for (i = 0; i < level.createFXent.size; i++) {
                  ent = level.createFXent[i];
                  if(!ent_is_selected(ent)) {
                    continue;
                  }
                  ent remove_option(name);
                }
                update_selected_entities();
                clear_settable_fx();
              }
              remove_option(name) {
                self.v[name] = undefined;
              }
              delete_selection() {
                newArray = [];
                for (i = 0; i < level.createFXent.size; i++) {
                  ent = level.createFXent[i];
                  if(ent_is_selected(ent)) {
                    if(isDefined(ent.looper))
                      ent.looper delete();
                    ent notify("stop_loop");
                  } else
                    newArray[newArray.size] = ent;
                }
                level.createFXent = newArray;
                level.selected_fx = [];
                level.selected_fx_ents = [];
                clear_fx_hudElements();
              }
              move_selection_to_cursor() {
                origin = level.createfxCursor["position"];
                if(level.selected_fx_ents.size <= 0) {
                  return;
                }
                center = get_center_of_array(level.selected_fx_ents);
                difference = center - origin;
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  if(isDefined(ent.model)) {
                    continue;
                  }
                  ent.v["origin"] -= difference;
                }
              }
              insert_effect() {
                setMenu("creation");
                level.effect_list_offset = 0;
                clear_fx_hudElements();
                set_fx_hudElement("Pick effect type to create:");
                set_fx_hudElement("1. One Shot fx");
                set_fx_hudElement("2. Looping fx");
                set_fx_hudElement("3. Looping sound");
                set_fx_hudElement("4. Exploder");
                set_fx_hudElement("(c) Cancel");
                set_fx_hudElement("(x) Exit");
              }
              show_help() {
                clear_fx_hudElements();
                set_fx_hudElement("Help:");
                set_fx_hudElement("InsertInsert entity");
                set_fx_hudElement("L Drop selected entities to the ground");
                set_fx_hudElement("A Add option to the selected entities");
                set_fx_hudElement("P Reset the rotation of the selected entities");
                set_fx_hudElement("V Copy the angles from the most recently selected fx onto all selected fx.");
                set_fx_hudElement("DeleteKill the selected entities");
                set_fx_hudElement("ESCAPECancel out of option-modify-mode, must have console open");
                set_fx_hudElement("Ctrl-CCopy");
                set_fx_hudElement("Ctrl-VPaste");
                set_fx_hudElement("F2Toggle createfx dot and text drawing");
                set_fx_hudElement("F5SAVES your work");
                set_fx_hudElement("DpadMove selected entitise on X/Y or rotate pitch/yaw");
                set_fx_hudElement("A buttonToggle the selection of the current entity");
                set_fx_hudElement("X buttonToggle entity rotation mode");
                set_fx_hudElement("Y buttonMove selected entites up or rotate roll");
                set_fx_hudElement("B buttonMove selected entites down or rotate roll");
                set_fx_hudElement("R ShoulderMove selected entities to the cursor");
                set_fx_hudElement("L ShoulderHold to select multiple entites");
                set_fx_hudElement("L JoyClickCopy");
                set_fx_hudElement("R JoyClickPaste");
                set_fx_hudElement("N UFO");
                set_fx_hudElement("T Toggle Timescale FAST");
                set_fx_hudElement("Y Toggle Timescale SLOW");
                set_fx_hudElement("[ Toggle FX Visibility");
                set_fx_hudElement("] Toggle ShowTris");
                set_fx_hudElement("F11 Toggle FX Profile");
              }
              select_last_entity() {
                select_entity(level.createFXent.size - 1, level.createFXent[level.createFXent.size - 1]);
              }
              copy_ents() {
                if(level.selected_fx_ents.size <= 0) {
                  return;
                }
                array = [];
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  newent = spawnstruct();
                  newent.v = ent.v;
                  newent post_entity_creation_function();
                  array[array.size] = newent;
                }
                level.stored_ents = array;
              }
              post_entity_creation_function() {
                self.textAlpha = 0;
                self.drawn = true;
              }
              paste_ents() {
                if(!isDefined(level.stored_ents)) {
                  return;
                }
                clear_entity_selection();
                for (i = 0; i < level.stored_ents.size; i++)
                  add_and_select_entity(level.stored_ents[i]);
                move_selection_to_cursor();
                update_selected_entities();
                level.stored_ents = [];
                copy_ents();
              }
              add_and_select_entity(ent) {
                level.createFXent[level.createFXent.size] = ent;
                select_last_entity();
              }
              stop_fx_looper() {
                if(isDefined(self.looper))
                  self.looper delete();
                self maps\mp\_fx::stop_loopsound();
              }
              restart_fx_looper() {
                stop_fx_looper();
                self set_forward_and_up_vectors();
                if(self.v["type"] == "loopfx") {
                  self maps\mp\_fx::create_looper();
                }
                if(self.v["type"] == "oneshotfx") {
                  self maps\mp\_fx::create_triggerfx();
                }
                if(self.v["type"] == "soundfx") {
                  self maps\mp\_fx::create_loopsound();
                }
              }
              update_selected_entities() {
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  ent restart_fx_looper();
                }
              }
              copy_angles_of_selected_ents() {
                level notify("new_ent_selection");
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  ent.v["angles"] = level.selected_fx_ents[level.selected_fx_ents.size - 1].v["angles"];
                  ent set_forward_and_up_vectors();
                }
                update_selected_entities();
              }
              reset_axis_of_selected_ents() {
                level notify("new_ent_selection");
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  ent.v["angles"] = (0, 0, 0);
                  ent set_forward_and_up_vectors();
                }
                update_selected_entities();
              }
              last_selected_entity_has_changed(lastSelectEntity) {
                if(isDefined(lastSelectEntity)) {
                  if(!entities_are_selected())
                    return true;
                } else
                  return entities_are_selected();
                return (lastSelectEntity != level.selected_fx_ents[level.selected_fx_ents.size - 1]);
              }
              createfx_showOrigin(id, org, delay, org2, type, exploder, id2, fireFx, fireFxDelay, fireFxSound, fxSound, fxQuake, fxDamage, soundalias, repeat, delay_min, delay_max, damage_radius, fireFxTimeout) {}
              drop_selection_to_ground() {
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  trace = bullettrace(ent.v["origin"], ent.v["origin"] + (0, 0, -2048), false, undefined);
                  ent.v["origin"] = trace["position"];
                }
              }
              set_off_exploders() {
                level notify("createfx_exploder_reset");
                exploders = [];
                for (i = 0; i < level.selected_fx_ents.size; i++) {
                  ent = level.selected_fx_ents[i];
                  if(isDefined(ent.v["exploder"]))
                    exploders[ent.v["exploder"]] = true;
                }
                keys = getarraykeys(exploders);
                for (i = 0; i < keys.size; i++) {
                  exploder(keys[i]);
                }
              }
              draw_distance() {
                count = 0;
                if(getdvarint("createfx_drawdist") == 0)
                  setdvar("createfx_drawdist", "1500");
                for (;;) {
                  maxDist = getdvarint("createfx_drawdist");
                  for (i = 0; i < level.createFXent.size; i++) {
                    ent = level.createFXent[i];
                    ent.drawn = distance(level.player.origin, ent.v["origin"]) <= maxDist;
                    count++;
                    if(count > 100) {
                      count = 0;
                      wait(0.05);
                    }
                  }
                  if(level.createFXent.size == 0)
                    wait(0.05);
                }
              }
              createfx_autosave() {
                for (;;) {
                  flag_waitopen("createfx_saving");
                  wait_time = GetDvarInt("createfx_autosave_time");
                  if(wait_time < 10 || IsString(wait_time)) {
                    wait_time = 60;
                  }
                  wait(wait_time);
                  seconds_since_save = (GetTime() - (level._createfx_start_time + level._createfx_time_saved)) / 1000;
                  if(!flag("createfx_saving") && (seconds_since_save > wait_time)) {
                    old_time = GetTime();
                    println("^5#### CREATEFX AUTOSAVE BEGIN ####");
                    generate_fx_log(true);
                    new_time = GetTime();
                    println("^5#### CREATEFX AUTOSAVE COMPLETE (Time: " + (new_time - old_time) * 0.001 + " seconds) at " + timecode(new_time - level._createfx_start_time) + " ####");
                  }
                }
              }
              Callback_PlayerConnect() {
                self waittill("begin");
                if(!isDefined(level.hasSpawned)) {
                  spawnpoints = getentarray("mp_global_intermission", "classname");
                  assert(spawnpoints.size);
                  spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
                  self.sessionteam = "none";
                  self.sessionstate = "playing";
                  self spawn(spawnpoint.origin, spawnpoint.angles);
                  level.player = self;
                  level.hasSpawned = true;
                } else
                  kick(self.name);
              }
              move_player_around_map_fast() {
                player = level.player;
                direction = player getPlayerAngles();
                direction_vec = anglesToForward(direction);
                eye = player getEye();
                trace = bullettrace(eye, eye + vector_scale(direction_vec, 8000), 0, undefined);
                dist = distance(eye, trace["position"]);
                position = eye + vector_scale(direction_vec, (dist - 64));
                player setorigin(position);
              }
              timecode(time_in_ms) {
                totalseconds = int(time_in_ms * 0.001);
                hours = int(totalseconds / 3600);
                minutes = int((totalseconds - (hours * 3600)) / 60);
                seconds = int(totalseconds - (hours * 3600) - (minutes * 60));
                time = "";
                if(hours < 10) {
                  time = "0" + hours + ":";
                } else {
                  time = hours + ":";
                }
                if(minutes < 10) {
                  time = time + "0" + minutes + ":";
                } else {
                  time = time + minutes + ":";
                }
                if(seconds < 10) {
                  time = time + "0" + seconds;
                } else {
                  time = time + seconds;
                }
                return time;
              }
              void() {}
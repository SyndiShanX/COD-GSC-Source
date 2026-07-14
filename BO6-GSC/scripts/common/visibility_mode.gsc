/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\visibility_mode.gsc
**********************************************/

#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace visibility_mode;

function main(funcsarray) {
  level thread visibilitymode_start(funcsarray);
}

function private visibilitymode_start(funcsarray) {
  default_dvar_value = getdvarint(@ "hash_33a01af682caae50", 0);
  setdvarifuninitialized(@ "hash_33a01af682caae50", default_dvar_value);

  if(getdvarint(@ "hash_33a01af682caae50", -1) <= 0) {
    return;
  }

  level.visibilitymode = spawnStruct();
  level.visibilitymode.activeclients = [];
  level.visibilitymode.funcs = [];

  if(isfunction(funcsarray)) {
    funcsarray = [[funcsarray]]();
  }

  foreach(index, func in funcsarray) {
    level.visibilitymode.funcs[index] = func;
  }

  if(!checkshouldrun()) {
    return;
  }

  level thread function_fb09c5028e28b9d2();

  level thread function_cba4789ea1db2c01();
  setdevdvarifuninitialized(@ "hash_b5ef409e5a4852e1", 0);
  devgui::function_9082edeb5db93280("<dev string:x24>");
  devgui::add_devgui_command("<dev string:x36>", "<dev string:x52>");
  devgui::function_77df7fe7dd273e10();
}

function private checkshouldrun() {
  if(isDefined(level.visibilitymode.funcs["shouldRun"])) {
    return level[[level.visibilitymode.funcs["shouldRun"]]]();
  }

  return 0;
}

function private function_fb09c5028e28b9d2() {
  level endon("game_ended");

  if(isDefined(level.visibilitymode.funcs["init"])) {
    level[[level.visibilitymode.funcs["init"]]]();
  }

  level childthread[[level.visibilitymode.funcs["checkForDataUpdates"]]]();
}

function private function_6e377c52ea0c5021(subteamname) {
  return subteamname == "contested" || subteamname == "interactable";
}

function private function_2913966bb9d9528c(model) {
  return issubstr(model, "enemy") || issubstr(model, "axis") || issubstr(model, "villain") || issubstr(model, "zmb");
}

function private function_d95597874a9fa0af(model) {
  return issubstr(model, "mannequin") || level.visibilitymode.var_27c4c9fcc37919a3 && arraycontains(level.visibilitymode.var_27c4c9fcc37919a3, model);
}

function function_ceeb7b4ab2524022(model) {
  if(!isDefined(level.visibilitymode.var_27c4c9fcc37919a3)) {
    level.visibilitymode.var_27c4c9fcc37919a3 = [];
  }

  level.visibilitymode.var_27c4c9fcc37919a3[level.visibilitymode.var_27c4c9fcc37919a3.size] = model;
}

function private function_50b0ba3d0e90b5fa(firstplayer, secondplayer) {
  if(utility::issp()) {
    return (firstplayer.team == "axis" || firstplayer.team == "team3");
  }

  if(!(isDefined(firstplayer) && isDefined(secondplayer))) {
    return false;
  }

  if(!(isDefined(firstplayer.team) && isDefined(secondplayer.team))) {
    return false;
  }

  if(firstplayer.team == "neutral" || secondplayer.team == "neutral" || firstplayer.vismode_team == "neutral" || secondplayer.vismode_team == "neutral") {
    return false;
  }

  if(firstplayer.team == "civilian" || secondplayer.team == "civilian") {
    return false;
  }

  if(firstplayer.vismode_team === "interactable" || secondplayer.vismode_team === "interactable") {
    return false;
  }

  if(level.teambased) {
    return (firstplayer.team != secondplayer.team);
  }

  return false;
}

function private function_95e981dc10338880(ent) {
  return isalive(ent) || ent.visibilitymode_forced;
}

function private function_96ae31f5976b308d(client) {
  client endon("disconnect");
  client.visibilitymode_outlineenabled = 1;
  client.var_2edff02632a566d3 = 1;
  playernum = client getentitynumber();
  reloadtime = 0.5;

  if(isDefined(level.visibilitymode.funcs["getReloadTime"])) {
    reloadtime = [[level.visibilitymode.funcs["getReloadTime"]]]();
  }

  client childthread function_9febf7d797fd5e4e();
  client childthread visibilityMode_darkBackground_toggle();
  client childthread visibilityMode_checkSniperADS();
  client childthread function_f3efd351a2e9d5f3();

  while(client function_7037e2a45b50f307()) {
    wait reloadtime;

    if(!client function_7037e2a45b50f307()) {
      break;
    }

    if(!isalive(client)) {
      continue;
    }

    active_targets = [[level.visibilitymode.funcs["getTargetArray"]]](client);
    active_targets = arraycombine(active_targets, level.visibilitymode.forced_ents);

    if(getdvarint(@ "hash_b5ef409e5a4852e1", 0) == 1) {
      active_targets function_32f2391e797f980b();
    }

    for(i = 0; i < active_targets.size; i++) {
      if(!isDefined(active_targets[i])) {
        continue;
      }

      if(active_targets[i] == client) {
        continue;
      }

      if(!function_95e981dc10338880(active_targets[i])) {
        continue;
      }

      if(active_targets[i] function_e9fe288eaadefc01(client)) {
        continue;
      }

      if(isDefined(active_targets[i].visibilitymode_outlineids)) {
        if(isDefined(active_targets[i].visibilitymode_outlineids[playernum])) {
          if(client.var_2edff02632a566d3) {
            active_targets[i] function_829fd0368f95ebf2(client);
          }

          continue;
        }
      }

      if(isDefined(active_targets[i])) {
        active_targets[i] thread function_90efc4d493dbc11b(client);
      }
    }

    client.var_2edff02632a566d3 = undefined;
  }

  client.visibilitymode_outlineenabled = undefined;
  client notify("visibiltyMode_disabled");
}

function private function_c38ea625fdbc6e8() {
  if(isDefined(self.perks_active)) {
    foreach(perk in self.perks_active) {
      if(perk == "specialty_death_perception") {
        return true;
      }
    }
  }

  return false;
}

function private function_79bf5726a591d44d() {
  if(function_c38ea625fdbc6e8() == 0) {
    return false;
  }

  var_b02a4c84ace6829e = utility::callsharedfunc(#"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_further_insight");

  if(var_b02a4c84ace6829e) {
    return true;
  }

  return false;
}

function private function_90efc4d493dbc11b(client) {
  if(self.var_2fc3a5fb762afb6e) {
    return;
  }

  playernum = client getentitynumber();

  if(isDefined(self.visibilitymode_outlineids)) {
    if(isDefined(self.visibilitymode_outlineids[playernum])) {
      return;
    }
  }

  if(!isDefined(self.team)) {
    return;
  }

  if(function_d95597874a9fa0af(self.model)) {
    return;
  }

  if(function_50b0ba3d0e90b5fa(self, client)) {
    if(!function_e2231ad877b8d2fb(client.visibilitymode.enemytypevalue)) {
      return;
    }

    if(client.var_be044164245fc649) {
      self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_far_enemy", "outlinefill_highvis_far_enemy");
    } else if(client function_79bf5726a591d44d()) {
      self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_nodepth_enemy_deathperception_extended", "outlinefill_highvis_nodepth_enemy_deathperception_extended");
    } else if(client function_c38ea625fdbc6e8()) {
      self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_nodepth_enemy_deathperception", "outlinefill_highvis_nodepth_enemy_deathperception");
    } else if(self.visibilitymode_nodepth_far) {
      self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_nodepth_enemy_far", "outlinefill_highvis_nodepth_enemy_far");
    } else if(self.visibilitymode_nodepth) {
      self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_nodepth_enemy", "outlinefill_highvis_nodepth_enemy");
    } else {
      self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_enemy", "outlinefill_highvis_enemy");
    }
  } else if(function_eae50a354ba08ff(self)) {
    if(!function_e2231ad877b8d2fb(client.visibilitymode.interactabletypevalue)) {
      return;
    }

    self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_interactable", "outlinefill_highvis_interactable");
  } else if(function_f0ca1623f05b9982(self)) {
    if(!function_e2231ad877b8d2fb(client.visibilitymode.contestedtypevalue)) {
      return;
    }

    self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_contested", "outlinefill_highvis_contested");
  } else if(function_82bdb1a268a20930(self)) {
    if(!function_e2231ad877b8d2fb(client.visibilitymode.neutraltypevalue)) {
      return;
    }

    self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_neutral", "outlinefill_highvis_neutral");
  } else {
    if(!function_e2231ad877b8d2fb(client.visibilitymode.allytypevalue)) {
      return;
    }

    self.visibilitymode_outline = client function_e18a453a206411af("outline_highvis_ally", "outlinefill_highvis_ally");
  }

  enablefunc = level.visibilitymode.funcs["enableForClient"];

  if(!isDefined(self.visibilitymode_outlineids)) {
    self.visibilitymode_outlineids = [];
  }

  id = self[[enablefunc]](client, self.visibilitymode_outline, "lowest");
  clientnum = client getentitynumber();
  self.visibilitymode_outlineids[clientnum] = id;
  thread visibilitymode_disableoutlineoncallback(client);
  thread visibilityMode_disableOutlineOnDeath();
  thread visibilitymode_disableonsmokeocclude(client);
}

function private function_dca7ad6de26c754e() {
  if(!isDefined(self.visibilitymode_outlineids)) {
    return;
  }

  foreach(id in self.visibilitymode_outlineids) {
    if(isDefined(id)) {
      self[[level.visibilitymode.funcs["disable"]]](id);
    }
  }

  self.visibilitymode_outline = undefined;
  self.visibilitymode_outlineids = undefined;
}

function private visibilityMode_disableOutlineOnDeath() {
  level endon("game_ended");
  self notify("visibilityMode_disableOutlineOnDeath");
  self endon("visibilityMode_disableOutlineOnDeath");
  self waittill("death_or_disconnect");
  function_dca7ad6de26c754e();
}

function private visibilitymode_disableoutlineoncallback(client) {
  self endon("death");
  client endon("disconnect");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  clientnum = client getentitynumber();
  self notify("visibilityMode_disableOutlineOnCallback_" + clientnum);
  self endon("visibilityMode_disableOutlineOnCallback_" + clientnum);
}

function private function_bb8e1c03cf4f27c4(client) {
  if(!isDefined(self.visibilitymode_outlineids)) {
    return;
  }

  foreach(playernum, id in self.visibilitymode_outlineids) {
    clientnum = client getentitynumber();

    if(clientnum == playernum) {
      if(isDefined(id)) {
        self[[level.visibilitymode.funcs["disable"]]](id);
        self.visibilitymode_outlineids[playernum] = undefined;
      }
    }
  }
}

function private function_829fd0368f95ebf2(client) {
  function_bb8e1c03cf4f27c4(client);
  thread function_90efc4d493dbc11b(client);
}

function private visibilitymode_disableonsmokeocclude(client) {
  if(!isDefined(level.visibilitymode.funcs["outlineOccluded"])) {
    return;
  }

  clientnum = client getentitynumber();
  self notify("visibilityMode_disableOnsmokeOcclude_" + clientnum);
  self endon("visibilityMode_disableOnsmokeOcclude_" + clientnum);
  self endon("death_or_disconnect");
  client endon("disconnect");
  client endon("visibiltyMode_disabled");

  while(true) {
    wait 0.5;

    if(!utility::within_fov(client.origin, client.angles, self.origin, 0.766)) {
      continue;
    }

    if(function_e9fe288eaadefc01(client)) {
      function_bb8e1c03cf4f27c4(client);
      return;
    }
  }
}

function private function_e9fe288eaadefc01(client) {
  if(!isDefined(level.visibilitymode.funcs["outlineOccluded"])) {
    return false;
  }

  if(client function_c38ea625fdbc6e8()) {
    return false;
  }

  self_eye = undefined;

  if(issentient(self)) {
    self_eye = self getEye();
  } else if(self.visibilitymode_forced) {
    if(self tagexists("TAG_EYE")) {
      self_eye = self gettagorigin("TAG_EYE");
    } else if(self tagexists("TAG_HEAD")) {
      self_eye = self gettagorigin("TAG_HEAD");
    } else {
      midpoint = function_decb653c5689e4ca(self.model);
      self_eye = self.origin + (0, 0, midpoint[2] * 2);
    }
  }

  if(!isDefined(self_eye)) {
    return false;
  }

  if([[level.visibilitymode.funcs["outlineOccluded"]]](client getEye(), self_eye)) {
    return true;
  }

  return false;
}

function private function_27681dbae81ca66c(client, teamname, soldiersarray, var_a096955ad60758c3) {
  if(function_6e377c52ea0c5021(teamname)) {
    self.vismode_team = teamname;
  } else {
    if(isDefined(teamname) && teamname != "") {
      self.team = teamname;
    } else if(!isDefined(self.team) || self.team == "") {
      self.team = "axis";
    }

    self.vismode_team = undefined;
  }

  if(var_a096955ad60758c3) {
    self.agentname = undefined;
    self.name = undefined;
  }

  if(!isDefined(self.var_69950ffb5182cc5c)) {
    self.var_69950ffb5182cc5c = [];
  }

  playernum = client getentitynumber();

  if(teamname != self.var_69950ffb5182cc5c[playernum]) {
    function_829fd0368f95ebf2(client);
    self.var_69950ffb5182cc5c[playernum] = teamname;

    if(isent(self.headmodel)) {
      function_3afc3bc470c80e61(self.headmodel, teamname);
    }
  }
}

function private function_82bdb1a268a20930(ent) {
  if(ent.vismode_team == "neutral" || ent.vismode_team == "civilian") {
    return true;
  }

  return ent.team === "neutral" || ent.team == "civilian";
}

function private function_eae50a354ba08ff(ent) {
  if(isDefined(ent.vismode_team)) {
    return (ent.vismode_team === "interactable");
  }

  return false;
}

function private function_f0ca1623f05b9982(ent) {
  if(isDefined(ent.vismode_team)) {
    return (ent.vismode_team === "contested");
  }

  return false;
}

function private function_e18a453a206411af(outlineshader, insideshader) {
  shader_color = outlineshader;

  if(isDefined(self.visibilitymode) && isDefined(self.visibilitymode.outlinevalue)) {
    if(self.visibilitymode.outlinevalue == 0) {
      shader_color = insideshader;
    }
  }

  return shader_color;
}

function private function_e2231ad877b8d2fb(typesetting) {
  return typesetting == 1;
}

function private function_1260ba78b6caf0b2() {
  active_targets = [[level.visibilitymode.funcs["getTargetArray"]]](self);
  returnguys = [];
  playernum = self getentitynumber();

  for(i = 0; i < active_targets.size; i++) {
    if(isDefined(active_targets[i].visibilitymode_outlineids)) {
      if(isDefined(active_targets[i].visibilitymode_outlineids[playernum])) {
        returnguys[returnguys.size] = active_targets[i];
      }
    }
  }

  return returnguys;
}

function private function_bc63e37cae86a444() {
  if(isDefined(level.players)) {
    activeplayers = [];

    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] function_7037e2a45b50f307()) {
        activeplayers[activeplayers.size] = level.players[i];
      }
    }

    return activeplayers;
  }

  if(isDefined(level.player)) {
    return level.player function_7037e2a45b50f307();
  }

  return [];
}

function private function_9febf7d797fd5e4e() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("visibiltyMode_disabled");

  while(true) {
    level waittill("highvis_reload_outline", teamname, soldiersarray, var_a096955ad60758c3);

    foreach(soldier in soldiersarray) {
      if(!function_95e981dc10338880(soldier)) {
        continue;
      }

      if(soldier.var_2fc3a5fb762afb6e) {
        soldier function_dca7ad6de26c754e();
        continue;
      }

      soldier function_27681dbae81ca66c(self, teamname, soldiersarray, var_a096955ad60758c3);
    }
  }
}

function visibilitymode_unpackvalue(value) {
  enable_value = self.visibilitymode.enablevalue;

  if(isDefined(enable_value)) {
    if(enable_value == 0) {
      active_targets = [[level.visibilitymode.funcs["getTargetArray"]]](self);
      active_targets = arraycombine(active_targets, level.visibilitymode.forced_ents);

      for(index = 0; index < active_targets.size; index++) {
        if(isDefined(active_targets[index])) {
          active_targets[index] function_bb8e1c03cf4f27c4(self);
        }
      }

      function_bb8e1c03cf4f27c4(self);
      thread visibilityMode_darkBackground_toggle(0);
      return;
    }

    function_829fd0368f95ebf2(self);
    level.visibilitymode.activeclients = function_bc63e37cae86a444();

    if(level.visibilitymode.activeclients.size > 0) {
      for(index = 0; index < level.visibilitymode.activeclients.size; index++) {
        if(isDefined(level.visibilitymode.activeclients[index])) {
          if(!isDefined(level.visibilitymode.activeclients[index].visibilitymode_outlineenabled)) {
            level thread function_96ae31f5976b308d(level.visibilitymode.activeclients[index]);
            continue;
          }

          level.visibilitymode.activeclients[index].var_2edff02632a566d3 = 1;
        }
      }
    }
  }
}

function private visibilityMode_checkSniperADS() {
  self endon("disconnect");
  self endon("visibiltyMode_disabled");
  self notify("visibilityMode_checkSniperADS");
  self endon("visibilityMode_checkSniperADS");

  for(var_6ac32a50cf4eb977 = 0.25; true; var_6ac32a50cf4eb977 = 0.25) {
    wait var_6ac32a50cf4eb977;

    if(!isDefined(self) || !isalive(self)) {
      continue;
    }

    weapondist = self[[level.visibilitymode.funcs["getADSWeaponDist"]]]();
    playerads = self playerads();

    if(self.var_22aa2a942de044fe || weapondist > 3000 && playerads > 0.95) {
      if(!isDefined(self.var_be044164245fc649)) {
        self.var_be044164245fc649 = 1;
        self.var_2edff02632a566d3 = 1;
      }

      var_6ac32a50cf4eb977 = 0.05;
      continue;
    }

    if(self.var_be044164245fc649) {
      self.var_be044164245fc649 = undefined;
      self.var_2edff02632a566d3 = 1;
    }
  }
}

function private visibilityMode_darkBackground_toggle(inputoverride = undefined) {
  self endon("disconnect");
  self notify("visibilityMode_darkBackground_toggle");
  self endon("visibilityMode_darkBackground_toggle");

  if(!utility::issp()) {
    utility::ent_flag_wait("player_active");
    utility::flag_wait("begin_round_logic");
  }

  if(isDefined(inputoverride)) {
    self[[level.visibilitymode.funcs["toggleDarkBackground"]]](inputoverride);
    self.visibilitymode.adsconfirm = inputoverride;
    return;
  }

  var_1cdfb4bb2321bb2d = 99;

  while(true) {
    if(isDefined(level.visibilitymode.funcs["toggleCheckData"])) {
      if(self[[level.visibilitymode.funcs["toggleCheckData"]]]()) {
        wait 1;
        var_1cdfb4bb2321bb2d = 99;
      }
    }

    intoggle = function_63e3a5209106205b();

    if(var_1cdfb4bb2321bb2d != intoggle) {
      self[[level.visibilitymode.funcs["toggleDarkBackground"]]](intoggle);
      self.visibilitymode.adsconfirm = intoggle;
      var_1cdfb4bb2321bb2d = intoggle;
    }

    wait 0.1;
  }
}

function private function_f3efd351a2e9d5f3() {
  if(getdvarint(@ "hash_c00bd962df7cb7b4", 0) > 0) {
    return;
  }

  childthread function_6956e5d6d213376();
}

function private function_82b48b65aa862431() {
  tracedata = function_172efe6a4531f856();
  entity = tracedata.entity;

  if(isDefined(entity.team) && isDefined(entity) && isDefined(entity.visibilitymode_outline)) {
    if(function_50b0ba3d0e90b5fa(entity, self)) {
      if(!function_e2231ad877b8d2fb(level.player.visibilitymode.enemytypevalue)) {
        return;
      }

      ispinged = 0;

      if(tracedata.type == "middle") {
        if(ispinged) {
          if(soundexists("ui_text_type")) {
            self playlocalsound("ui_text_type");
          }
        }

        if(soundexists("2pop")) {
          self playlocalsound("2pop");
        }
      } else if(tracedata.type == "middle_near") {
        if(ispinged) {
          if(soundexists("ui_menu_ability_hover")) {
            self playlocalsound("ui_menu_ability_hover");
          }
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
        }
      } else if(tracedata.type == "left") {
        if(ispinged) {
          if(soundexists("ui_menu_ability_hover")) {
            self playlocalsound("ui_menu_ability_hover");
          }
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
        }
      } else {
        if(ispinged) {
          if(soundexists("ui_menu_ability_hover")) {
            self playlocalsound("ui_menu_ability_hover");
          }
        }

        if(soundexists("2pop_low")) {
          self playlocalsound("2pop_low");
        }
      }

      return;
    }

    if(isPlayer(entity)) {
      if(!function_e2231ad877b8d2fb(level.player.visibilitymode.allytypevalue)) {
        return;
      }

      if(soundexists("ui_chyron_firstline")) {
        self playlocalsound("ui_chyron_firstline");
      }

      return;
    }

    if(!function_e2231ad877b8d2fb(level.player.visibilitymode.allytypevalue)) {
      return;
    }

    if(soundexists("ui_chyron_plusminus")) {
      self playlocalsound("ui_chyron_plusminus");
    }
  }
}

function private function_172efe6a4531f856() {
  tracedist = self[[level.visibilitymode.funcs["getADSWeaponDist"]]]();
  playerangles = self getgunangles();
  traceend = self getEye() + anglesToForward(playerangles) * tracedist;
  traceoffset = (0, 0, 0);
  tracevecoffset = 32;
  returndata = spawnStruct();
  returndata.entity = undefined;
  returndata.type = "middle";

  for(i = 0; i < 15; i++) {
    if(i == 1) {
      traceoffset = rotatevector((0, tracevecoffset * -1, 0), playerangles);
      returndata.type = "left";
    } else if(i == 2) {
      traceoffset = rotatevector((0, tracevecoffset, 0), playerangles);
      returndata.type = "right";
    } else if(i == 3) {
      traceoffset = rotatevector((0, 0, tracevecoffset), playerangles);
      returndata.type = "middle_near";
    } else if(i == 4) {
      traceoffset = rotatevector((0, tracevecoffset * -1, tracevecoffset), playerangles);
      returndata.type = "left";
    } else if(i == 5) {
      traceoffset = rotatevector((0, tracevecoffset, tracevecoffset), playerangles);
      returndata.type = "right";
    } else if(i == 6) {
      traceoffset = rotatevector((0, 0, tracevecoffset * -1), playerangles);
      returndata.type = "middle_near";
    } else if(i == 7) {
      traceoffset = rotatevector((0, tracevecoffset * -1, tracevecoffset * -1), playerangles);
      returndata.type = "left";
    } else if(i == 8) {
      traceoffset = rotatevector((0, tracevecoffset, tracevecoffset * -1), playerangles);
      returndata.type = "right";
    } else if(i == 9) {
      traceoffset = rotatevector((0, tracevecoffset * -2, tracevecoffset), playerangles);
      returndata.type = "left";
    } else if(i == 10) {
      traceoffset = rotatevector((0, tracevecoffset * -2, 0), playerangles);
      returndata.type = "left";
    } else if(i == 11) {
      traceoffset = rotatevector((0, tracevecoffset * -2, tracevecoffset * -1), playerangles);
      returndata.type = "left";
    } else if(i == 12) {
      traceoffset = rotatevector((0, tracevecoffset * 2, tracevecoffset), playerangles);
      returndata.type = "right";
    } else if(i == 13) {
      traceoffset = rotatevector((0, tracevecoffset * 2, 0), playerangles);
      returndata.type = "right";
    } else if(i == 14) {
      traceoffset = rotatevector((0, tracevecoffset * 2, tracevecoffset * -1), playerangles);
      returndata.type = "right";
    }

    trace = trace::ray_trace(self getEye(), traceend + traceoffset);

    if(isDefined(trace["entity"]) && (isPlayer(trace["entity"]) || issentient(trace["entity"]))) {
      if(returndata.type == "middle") {
        returndata.type = function_74a7309da4cbb19c(trace, playerangles, tracedist);
      }

      returndata.entity = trace["entity"];
      return returndata;
    }
  }

  return returndata;
}

function private function_74a7309da4cbb19c(trace, playerangles, tracedist) {
  targeteyespos = trace["entity"] getEye();
  targetoriginpos = trace["entity"] gettagorigin("tag_origin", 1);
  var_b4fe35cf7e8d789 = self getEye() + anglesToForward(playerangles) * tracedist * 1.5;

  if(isDefined(targeteyespos) && isDefined(targetoriginpos)) {
    data = utility::closestdistancebetweenlines(targetoriginpos, targeteyespos, self getEye(), var_b4fe35cf7e8d789);

    if(isDefined(data) && data[2] < 7) {
      return "middle";
    } else if(isDefined(data)) {
      up = anglestoup(playerangles);
      var_4e98d1a6c805d862 = vectornormalize2(var_b4fe35cf7e8d789 - self.origin);
      metotarget = vectornormalize2(targetoriginpos - self.origin);
      angbetween = math::anglebetweenvectorssigned(var_4e98d1a6c805d862, metotarget, up);

      if(angbetween > 0) {
        return "right";
      } else {
        return "left";
      }
    }
  }

  return "middle";
}

function private function_6956e5d6d213376() {
  if(getdvarint(@ "hash_ce71de9c111f3c9e", 0) > 0) {
    if(utility::issp()) {
      return;
    }
  }

  if(getdvarint(@ "hash_cdedca9c108ddd70", 0) > 0) {
    if(!utility::issp()) {
      return;
    }
  }

  self.visibilitymodeads = 0;
  self.var_8c6ce1e6e3b09db5 = 0;
  btracking = 0;
  self notifyonplayercommand("vis_sprint_pressed", "+breath_sprint");
  self notifyonplayercommand("vis_sprint_pressed", "+melee_breath");
  self notifyonplayercommand("vis_sprint_pressed", "+melee_zoom");
  self notifyonplayercommand("vis_sprint_pressed", "+melee");

  while(function_7037e2a45b50f307()) {
    wait 0.1;

    if(!isalive(self)) {
      continue;
    }

    if(!function_9cbed71c0031704d()) {
      wait 1;
      continue;
    }

    playerads = self playerads();

    if(isDefined(level.visibilitymode.funcs["getPlayerADS"])) {
      playerads = self[[level.visibilitymode.funcs["getPlayerADS"]]]();
    }

    if(!btracking) {
      if(playerads > 0.5 && self jumpbuttonPressed() && self useButtonPressed() && self weaponswitchbuttonPressed()) {
        btracking = 1;
      }

      continue;
    }

    if(playerads > 0.5) {
      if(self.visibilitymodeads == 0) {
        self.visibilitymodeads = 1;
        thread function_6f904f210491d609("vis_sprint_pressed");
      }

      continue;
    }

    if(playerads < 0.5) {
      self.visibilitymodeads = 0;
      self.var_8c6ce1e6e3b09db5 = 0;
      self notify("visibilityMode_stopads");
    }
  }
}

function private function_6f904f210491d609(type) {
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");

  if(type == "vis_sprint_pressed") {
    while(true) {
      self waittill("vis_sprint_pressed");
      wait 0.1;
      mountfrac = self playermount();

      if(mountfrac > 0) {
        continue;
      }

      function_26fe830c681419cd();
      function_533410d3e412bdf9();
      function_ecef4235a005ee0();
      function_884a746cd65e7eb0();

      if(isDefined(level.visibilitymode.funcs["playUsablesSound"])) {
        self[[level.visibilitymode.funcs["playUsablesSound"]]]();
      }
    }
  }
}

function private function_26fe830c681419cd() {
  self notify("28c7287dbfaf35e4");
  self endon("28c7287dbfaf35e4");

  if(getdvarint(@ "hash_5330d65f1b02debf", 0) > 0) {
    return;
  }

  if(self getstance() != "prone") {
    return;
  }

  myangles = self getplayerangles();

  if(isDefined(myangles) && myangles[0] < 40) {
    return;
  }

  angles = (0, self.angles[1], self.angles[2]);
  self setplayerangles(angles);
}

function private function_ecef4235a005ee0() {
  self notify("bced1bb63a253e24");
  self endon("bced1bb63a253e24");
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");
  self endon("vis_sprint_pressed");

  if(level.visibilitymode.var_d60b4bc1a5e11789) {
    return;
  }

  if(getdvarint(@ "hash_dfb0535275001743", 0) > 0) {
    return;
  }

  clientallies = function_956d237eca536d16();
  active_players = [];
  var_2eefa2d05661ed02 = [];

  foreach(ally in clientallies) {
    if(!isDefined(ally) || !isalive(ally)) {
      continue;
    }

    if(isPlayer(ally)) {
      if(ally == self) {
        continue;
      }

      active_players[active_players.size] = ally;
      continue;
    }

    var_2eefa2d05661ed02[var_2eefa2d05661ed02.size] = ally;
  }

  active_players = sortbydistance(active_players, self.origin);

  for(i = 0; i < active_players.size; i++) {
    if(!active_players[i].inlaststand) {
      if(soundexists("uin_ping_confirm")) {
        active_players[i] utility::callsharedfunc(#"sound", #"playsoundtoplayer", "uin_ping_confirm", self);
      }
    } else if(soundexists("uin_ping_wheel_announce_help")) {
      active_players[i] utility::callsharedfunc(#"sound", #"playsoundtoplayer", "uin_ping_wheel_announce_help", self);
    }

    if(active_players.size > 1) {
      wait 0.2;
    }
  }

  if(active_players.size > 0) {
    wait 0.5;
  }

  var_2eefa2d05661ed02 = sortbydistancecullbyradius(var_2eefa2d05661ed02, self.origin, 768);

  if(isDefined(var_2eefa2d05661ed02) && var_2eefa2d05661ed02.size > 0) {
    var_21d016893db2690 = min(4, var_2eefa2d05661ed02.size);

    for(i = 0; i < var_21d016893db2690; i++) {
      if(soundexists("uin_ping_ally")) {
        var_2eefa2d05661ed02[i] utility::callsharedfunc(#"sound", #"playsoundtoplayer", "uin_ping_ally", self);
      } else if(soundexists("recondrone_lockon")) {
        var_2eefa2d05661ed02[i] utility::callsharedfunc(#"sound", #"playsoundtoplayer", "recondrone_lockon", self);
      }

      if(var_2eefa2d05661ed02.size > 1) {
        wait 0.2;
      }
    }
  }

  if(var_2eefa2d05661ed02.size > 0) {
    wait 0.5;
  }
}

function private function_533410d3e412bdf9() {
  self notify("e5ea3ec8df5a32a");
  self endon("e5ea3ec8df5a32a");
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");
  self endon("vis_sprint_pressed");

  if(getdvarint(@ "hash_ea1d4c9f2becad27", 0) > 0) {
    return;
  }

  if(getdvarint(@ "hash_8449df3b0c2b6ce1", 0) > 0) {
    if(!utility::issp()) {
      return;
    }
  }

  if(getdvarint(@ "hash_e5d5f87126e44fa9", 0) > 0) {
    if(self.var_8c6ce1e6e3b09db5 == 0) {
      self.var_8c6ce1e6e3b09db5 = 1;
    } else {
      return;
    }
  }

  maxdist = self[[level.visibilitymode.funcs["getADSWeaponDist"]]]();
  maxdistsq = squared(maxdist);
  clientenemies = function_7ab1306fcb9b0a70();
  clientenemies = sortbydistance(clientenemies, self.origin);
  var_21d016893db2690 = min(5, clientenemies.size);
  numhit = 0;

  for(i = 0; i < var_21d016893db2690; i++) {
    if(!function_d8599342b7a75d3b(self, clientenemies[i])) {
      continue;
    }

    if(!isDefined(clientenemies[i]) || !isalive(clientenemies[i])) {
      continue;
    }

    disttome = distancesquared(clientenemies[i].origin, self.origin);

    if(disttome < maxdistsq) {
      soundtoplay = undefined;

      if(soundexists("uin_ping_enemy")) {
        soundtoplay = "uin_ping_enemy";
      } else if(soundexists("eqp_frag_grenade_expl_trans")) {
        soundtoplay = "eqp_frag_grenade_expl_trans";
      }

      if(isDefined(soundtoplay)) {
        numhit++;
        clientenemies[i] utility::callsharedfunc(#"sound", #"playsoundtoplayer", soundtoplay, self);
        delay = math::remap(disttome, 0, maxdistsq, 0.15, 0.6);
        wait delay;
      }
    }
  }

  if(numhit > 0) {
    wait 0.5;
  }
}

function private function_884a746cd65e7eb0() {
  self notify("829ce1259c506cb0");
  self endon("829ce1259c506cb0");
  self endon("death_or_disconnect");
  self endon("visibilityMode_stopads");
  self endon("vis_sprint_pressed");

  if(level.visibilitymode.var_98feaf41a6767fcf) {
    return;
  }

  if(getdvarint(@ "hash_1410d9fa2e9b42a6", 0) > 0) {
    return;
  }

  if(getdvarint(@ "hash_643d298034d30ac6", 0) > 0) {
    if(!utility::issp()) {
      return;
    }
  }

  objposarray = [];

  if(isDefined(level.objectiveidpool.active)) {
    foreach(objective in level.objectiveidpool.active) {
      if(objective.identifier == "nonobj_marker") {
        continue;
      }

      if(!isDefined(objective.objid)) {
        continue;
      }

      objstruct = spawnStruct();
      objstruct.objinfo = objective;
      objstruct.origin = objective_getlocation(objective.objid, 0);

      if(distance(objstruct.origin, (0, 0, 0)) < 1) {
        continue;
      }

      objposarray[objposarray.size] = objstruct;
    }
  } else if(isDefined(level.objective_array)) {
    for(i = 0; i < level.objective_array.size; i++) {
      if(!isDefined(level.objective_array[i].objid)) {
        continue;
      }

      objstruct = spawnStruct();
      objstruct.origin = objective_getlocation(level.objective_array[i].objid, 0);

      if(distance(objstruct.origin, (0, 0, 0)) < 1) {
        continue;
      }

      objposarray[objposarray.size] = objstruct;
    }
  }

  if(objposarray.size > 0) {
    objposarray = sortbydistance(objposarray, self.origin);

    for(i = 0; i < objposarray.size; i++) {
      potentialcustomsound = undefined;

      if(isDefined(objposarray[i].objinfo.identifier)) {
        potentialcustomsound = function_8bbf3ff9313838fc(objposarray[i].objinfo.identifier);
      }

      if(isDefined(potentialcustomsound)) {
        level thread function_55d2937cbb12213e(objposarray[i].origin, self, potentialcustomsound);
      } else {
        level thread function_55d2937cbb12213e(objposarray[i].origin, self);
      }

      if(objposarray.size > 1) {
        wait 0.5;
      }
    }
  }

  if(getdvarint(@ "hash_9fc9beff87655c5d", 0) > 0) {
    return;
  }

  wait 0.25;
  perkmachines = [];

  if(isDefined(level.interacts)) {
    foreach(interact in level.interacts) {
      if(isDefined(interact.s_perk_machine)) {
        perkmachines[perkmachines.size] = interact;
      }
    }
  }

  ascender_scriptables = getscriptablearray("zm_forcefield_ziplines", #script_noteworthy);
  ascenders = [];

  foreach(scriptable in ascender_scriptables) {
    if(isDefined(scriptable.origin) && scriptable isscriptable()) {
      ascenders[ascenders.size] = scriptable;
    }
  }

  radius = getdvarint(@ "hash_919d1502053e2776", 512);
  function_d1ea9113f418f5c9(level.var_6c83d1b7ba6fafa5.var_ea07e36d8fd28578, "flag_spawned_foley", self, radius);
  radius = getdvarint(@ "hash_3f85ec9dcfef2dc", 450);
  function_d1ea9113f418f5c9(level.var_caf65b937e9cbfaf, "prj_bullet_small_plr", self, radius);
  radius = getdvarint(@ "hash_e4c5808d4390b4d9", 384);
  function_d1ea9113f418f5c9(level.var_f301c0b95ea728e2, "vehicle_body_hit", self, radius);
  radius = getdvarint(@ "hash_4b9c923551b1ce98", 384);
  function_d1ea9113f418f5c9(level.a_s_doorbuys, "door_locked", self, radius);
  radius = getdvarint(@ "hash_a3a462b54c20ecec", 384);
  function_d1ea9113f418f5c9(level.var_e584ab91aed38e8c, "door_locked_bashed", self, radius);
  radius = getdvarint(@ "hash_fc90220c7c2dbeb1", 384);
  function_d1ea9113f418f5c9(ascenders, "door_locked_bashed", self, radius);
  radius = getdvarint(@ "hash_19b8cf6533d2dfb6", 256);
  function_d1ea9113f418f5c9(perkmachines, "flag_spawned", self, radius);
  radius = getdvarint(@ "hash_d58dfd64693adaa8", 256);
  function_d1ea9113f418f5c9(level.var_1bbb5557537e2c0c, "flag_spawned", self, radius);
}

function private function_d1ea9113f418f5c9(array, alias, player, radius) {
  if(!soundexists(alias)) {
    return;
  }

  if(!isDefined(level.contentmanager.spawnedinstances)) {
    return;
  }

  if(!isDefined(player.origin)) {
    return;
  }

  if(!isDefined(radius) || radius <= 0) {
    return;
  }

  if(isarray(array) && array.size > 0) {
    array = function_5713d46873b29625(array);
    nearbystructs = sortbydistancecullbyradius(array, player.origin, radius);

    foreach(struct in nearbystructs) {
      level thread function_55d2937cbb12213e(struct.origin, player, alias);
      wait 0.5;
    }
  }
}

function private function_55d2937cbb12213e(origin, player, customsound) {
  tag_origin = spawn("script_model", origin);
  tag_origin setModel("tag_origin");
  soundtoplay = undefined;

  if(soundexists("uin_ping_mission")) {
    soundtoplay = "uin_ping_mission";
  } else if(soundexists("player_death_generic")) {
    soundtoplay = "player_death_generic";
  }

  if(isDefined(customsound) && soundexists(customsound)) {
    soundtoplay = customsound;
  }

  if(!isDefined(soundtoplay)) {
    return;
  }

  tag_origin utility::callsharedfunc(#"sound", #"playsoundtoplayer", soundtoplay, player);
  wait lookupsoundlength(soundtoplay) / 1000;
  wait 1;
  tag_origin delete();
}

function private function_8bbf3ff9313838fc(var_8035e6a24b4c968d) {
  if(isDefined(level.visibilitymode.var_1940b70ca8fd3766)) {
    foreach(index, sound in level.visibilitymode.var_1940b70ca8fd3766) {
      if(index == var_8035e6a24b4c968d) {
        return sound;
      }
    }
  }

  return undefined;
}

function function_791f744be3e75f06(var_8035e6a24b4c968d, soundalias) {
  if(!isDefined(level.visibilitymode)) {
    return;
  }

  if(!isDefined(level.visibilitymode.var_1940b70ca8fd3766)) {
    level.visibilitymode.var_1940b70ca8fd3766 = [];
  }

  if(isDefined(level.visibilitymode.var_1940b70ca8fd3766[var_8035e6a24b4c968d])) {
    return;
  }

  level.visibilitymode.var_1940b70ca8fd3766[var_8035e6a24b4c968d] = soundalias;
}

function function_d8599342b7a75d3b(player, target) {
  if(!utility::within_fov(player.origin, player.angles, target.origin, 0.766)) {
    return false;
  }

  playereye = player getEye();
  feetorigin = target.origin;

  if(sighttracepassed(playereye, feetorigin, 1, player, target)) {
    return true;
  }

  eyeorigin = undefined;

  if(isagent(target)) {
    eyeorigin = target getapproxeyepos();
  } else {
    eyeorigin = target getEye();
  }

  if(sighttracepassed(playereye, eyeorigin, 1, player, target)) {
    return true;
  }

  midorigin = (eyeorigin + feetorigin) * 0.5;

  if(sighttracepassed(playereye, midorigin, 1, player, target)) {
    return true;
  }

  return false;
}

function function_32528d31de35fd5a(isenabled) {
  if(isDefined(self.visibilitymode) && isDefined(self.visibilitymode.enablevalue)) {
    self.visibilitymode.enablevalue = isenabled;
  }

  visibilitymode_unpackvalue();
}

function function_7037e2a45b50f307() {
  if(isDefined(self.visibilitymode) && isDefined(self.visibilitymode.enablevalue)) {
    return (self.visibilitymode.enablevalue > 0);
  }

  return false;
}

function function_9cbed71c0031704d() {
  adsconfirm = 0;

  if(isDefined(self.visibilitymode) && isDefined(self.visibilitymode.adsconfirm)) {
    adsconfirm = self.visibilitymode.adsconfirm;
  }

  return adsconfirm;
}

function function_63e3a5209106205b() {
  darkbackground = 0;

  if(isDefined(self.visibilitymode) && isDefined(self.visibilitymode.darkbackgroundvalue)) {
    darkbackground = self.visibilitymode.darkbackgroundvalue;
  }

  return darkbackground;
}

function function_7ab1306fcb9b0a70() {
  all_targets = function_1260ba78b6caf0b2();
  return_targets = [];

  for(i = 0; i < all_targets.size; i++) {
    if(function_50b0ba3d0e90b5fa(all_targets[i], self)) {
      return_targets[return_targets.size] = all_targets[i];
    }
  }

  return return_targets;
}

function function_956d237eca536d16() {
  all_targets = function_1260ba78b6caf0b2();
  return_targets = [];

  for(i = 0; i < all_targets.size; i++) {
    if(!function_50b0ba3d0e90b5fa(all_targets[i], self)) {
      return_targets[return_targets.size] = all_targets[i];
    }
  }

  return return_targets;
}

function function_3afc3bc470c80e61(entity, team) {
  if(isDefined(level.visibilitymode) && !isDefined(level.visibilitymode.forced_ents)) {
    level.visibilitymode.forced_ents = [];
  }

  entity.visibilitymode_forced = 1;
  ent_number = entity getentitynumber();
  var_6e377c52ea0c5021 = function_6e377c52ea0c5021(team);

  if(entity.team != team || var_6e377c52ea0c5021 && entity.vismode_team != team) {
    if(var_6e377c52ea0c5021) {
      entity.vismode_team = team;
    } else {
      entity.team = team;
    }

    level.visibilitymode.forced_ents[ent_number] = entity;
    level notify("highvis_reload_outline", team, [entity]);
  }
}

function function_4e6c654251b854e0(entity) {
  if(isDefined(entity)) {
    ent_number = entity getentitynumber();

    if(isDefined(level.visibilitymode.forced_ents) && isDefined(level.visibilitymode) && isDefined(level.visibilitymode.forced_ents[ent_number])) {
      entity.visibilitymode_forced = undefined;
      level.visibilitymode.forced_ents[ent_number] = undefined;
    }
  }
}

function function_db9ed9dc5c19305b() {
  entity = self;
  model = entity.model;

  if(entity.visibilitymode_forced) {
    return;
  }

  if(isPlayer(entity) || isai(entity) || issentient(entity)) {
    return;
  }

  if((self tagexists("TAG_EYE") || self tagexists("j_head")) && !function_d95597874a9fa0af(model)) {
    if(function_c975651ff9306a02(entity)) {
      function_3afc3bc470c80e61(entity, entity.team);
      return;
    }

    if(function_2913966bb9d9528c(model)) {
      function_3afc3bc470c80e61(entity, "axis");
      return;
    }

    function_3afc3bc470c80e61(entity, "allies");
  }
}

function function_c975651ff9306a02(entity) {
  return isDefined(entity.cratetype);
}

function private function_cba4789ea1db2c01() {
  level endon("game_ended");
  dvar = @ "hash_5ecd08979278a317";

  while(true) {
    var_e1f70dc44f099ae5 = getDvar(dvar, "");

    if(var_e1f70dc44f099ae5 != "") {
      if(var_e1f70dc44f099ae5 == "1") {
        level.players[0].visibilitymode.enablevalue = 1;
        level.players[0].visibilitymode.enemytypevalue = 1;
        level.players[0].visibilitymode.outlinevalue = 0;
        level.players[0].visibilitymode.visibilitymode_outlineenabled = 1;
        level.players[0].visibilitymode.adsconfirm = 1;
        level.players[0].visibilitymode.darkbackgroundvalue = 1;
      } else {
        level.players[0].visibilitymode.enablevalue = 0;
        level.players[0].visibilitymode.enemytypevalue = 1;
        level.players[0].visibilitymode.outlinevalue = 0;
        level.players[0].visibilitymode.visibilitymode_outlineenabled = 1;
        level.players[0].visibilitymode.adsconfirm = 1;
        level.players[0].visibilitymode.darkbackgroundvalue = 1;
      }

      level thread function_67b4115ae46df95f(var_e1f70dc44f099ae5);
      setDvar(dvar, "");
    }

    wait 0.1;
  }
}

function private function_67b4115ae46df95f(val) {
  val = int(val);
  level.players[0] visibilitymode_unpackvalue(val);
}

function private function_32f2391e797f980b() {
  ents_models = "<dev string:x79>";
  self_player = level.players[0];

  foreach(ent in self) {
    if(self_player != ent) {
      print3d(ent.origin + (0, 0, 75), ent.model, undefined, 1, 0.3, 300, 1);
    }
  }

  setdevdvar(@ "hash_b5ef409e5a4852e1", 0);
}

# /
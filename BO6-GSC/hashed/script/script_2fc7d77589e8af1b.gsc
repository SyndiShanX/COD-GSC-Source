/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_2fc7d77589e8af1b.gsc
*****************************************************/

#using script_178d5ed9c26037d0;
#using scripts\common\utility;
#using scripts\cp_mp\frontendutils;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\scriptable;
#using scripts\mp\utility\backpack;
#using scripts\mp\utility\streamhint;
#namespace namespace_e3dadaab7220964b;

function fadetoblackforplayer(player, fadetoblack, fadetime) {
  player notify("start_fade_to_black");
  player endon("start_fade_to_black");
  player endon("disconnect");
  assert(!isDefined(fadetime) || fadetime >= 0, "<dev string:x24>");
  fadealpha = 0;

  if(fadetoblack) {
    fadealpha = 1;
  }

  if(!isDefined(fadetime) || fadetime == 0) {
    setomnvar("ui_fob_loading_progress", fadealpha);
    return;
  }

  finalalpha = fadealpha;
  fadealpha = 0;
  fadetimecounter = int(fadetime / level.framedurationseconds);
  fadechange = 1 / fadetimecounter;

  if(!fadetoblack) {
    fadechange *= -1;
    fadealpha = 1;
  }

  while(fadetimecounter > 0) {
    fadealpha += fadechange;

    if(!isDefined(player) || !player isconnected()) {
      return;
    }

    setomnvar("ui_fob_loading_progress", fadealpha);
    fadetimecounter--;
    waitframe();
  }

  if(!isDefined(player)) {
    return;
  }

  setomnvar("ui_fob_loading_progress", finalalpha);
  player notify("finish_fade_to_black");
}

function function_2a0ac7d9080f76f(player, enable) {
  player allowfire(enable);
  player allowads(enable);
}

function function_54ffe751a4300210() {
  doors = scriptable_door_utility::scriptable_door_get_in_radius(self.origin, 512, 1000);

  foreach(door in doors) {
    door scriptabledoorfreeze(1);
  }
}

function private function_fd048ed205a845() {
  if(isDefined(self.primaryweaponobj)) {
    if(self hasweapon(self.primaryweaponobj)) {
      self takeweapon(self.primaryweaponobj);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    if(self hasweapon(self.secondaryweaponobj)) {
      self takeweapon(self.secondaryweaponobj);
    }
  }
}

function private function_8c7a5b2867bde7() {
  if(!(isDefined(self.primaryweaponobj) && isDefined(self.secondaryweaponobj))) {
    namespace_285f2d8d2827221c::update_player_weapon();
  }

  if(isDefined(self.primaryweaponobj)) {
    self giveweapon(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self giveweapon(self.secondaryweaponobj);
  }

  self switchtoweaponimmediate(self.primaryweaponobj);
}

function function_93b1960c20cec5f8() {
  self function_cb8df376b3e57420();
  setomnvar("ui_fob_loading_progress", 0.1);

  if(isDefined(level.playerspawnent)) {
    groundpos = level.playerspawnent.origin;
  } else if(isDefined(level.camera_walkable_space)) {
    groundpos = level.camera_walkable_space.basecam.origin;
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  viewmodelname = self getcustomizationviewmodel();
  self setModel(bodymodelname);
  self setviewmodel(viewmodelname);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }

  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  self.pers["streamSyncComplete"] = 1;
  println("<dev string:x5b>");
  streamhint::playerstreamhintlocation(groundpos, 50000);
  fadetoblackforplayer(self, 1, 0);
  streamhint::playerwaittillstreamhintcomplete();
  fadetoblackforplayer(self, 0, 0.5);
  self setnormalhealth(1);
}

function frontend_spawnplayer() {
  println("<dev string:x76>");
  self.guid = 0;
  self.team = "allies";
  self function_cb8df376b3e57420();

  if(isDefined(level.playerspawnent)) {
    groundpos = utility::groundpos(level.playerspawnent.origin);
    spawnangles = level.playerspawnent.angles;

    if(level.var_84937cfb956d7c1d) {
      spawnangles = (0, 90, 0);
    }

    self spawn(groundpos, spawnangles);
  } else if(isDefined(level.camera_walkable_space)) {
    groundpos = utility::groundpos(level.camera_walkable_space.basecam.origin);
    self spawn(groundpos, level.camera_walkable_space.basecam.angles);
  }

  self setnormalhealth(1);
  waitframe();
  function_8c7a5b2867bde7();
  function_1b6fa013c0c2b251(0);
  self setclienttriggeraudiozone("frontend_walkable_space", 0.25);
  setmusicstate("");
  self setcamerathirdperson(1);
  function_2a0ac7d9080f76f(self, 0);
  function_54ffe751a4300210();
  thread infiniteammo();
}

function private function_59c3f2207c0c8735(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance) && state != "objectivedisable") {
    setomnvar("ui_walkable_scene_trigger_index", instance.triggerindex);
    wait 2;
    setomnvar("ui_walkable_scene_trigger_index", -1);
  }
}

function function_42cec6872280e398(stateinfo) {
  var_f5eb361fd2d11f7e = strtok(stateinfo, "/");
  var_f5eb361fd2d11f7e = strtok(stateinfo, "+");

  if(isDefined(var_f5eb361fd2d11f7e)) {
    scriptablename = var_f5eb361fd2d11f7e[0];
    scriptablestate = var_f5eb361fd2d11f7e[1];

    if(isDefined(scriptablename) && isDefined(level.scriptables[scriptablename])) {
      scriptable = level.scriptables[scriptablename]["scriptable"];
      scriptable setscriptablepartstate(scriptablename, scriptablestate);
    }
  }
}

function private setstate(scriptablename, luastate) {
  state = undefined;

  if(luastate == "1") {
    state = "objectivesplash";
  } else if(luastate == "2") {
    state = "objectivedisable";
  } else if(luastate == "3") {
    state = "objective";
  }

  if(state) {
    scriptable = level.scriptables[scriptablename]["scriptable"];
    scriptable setscriptablepartstate(scriptablename, state);
  }
}

function private getunlocks() {
  sceneinteractables = getgamemodescriptbundle().triggersetup;

  if(sceneinteractables) {
    interactables = getscriptbundle(sceneinteractables);

    if(interactables) {
      unlocks = interactables.unlockdata;
      return unlocks;
    }
  }

  return undefined;
}

function function_b14158045d06087d(statestring) {
  sstate = strtok(statestring, "/");
  scriptablestates = strtok(sstate[0], "+");

  if(scriptablestates) {
    index = 0;
    unlocks = getunlocks();

    if(unlocks) {
      foreach(unlock in unlocks) {
        var_220bbb169e68b0fa = unlock.var_a4b97d76317fe1e9;

        foreach(var_71af9d27251cd56d in var_220bbb169e68b0fa) {
          scriptablename = var_71af9d27251cd56d.scriptable;

          if(scriptablename) {
            if(scriptablename != "dmz_deploy") {
              if(scriptablestates[index]) {
                scriptablestate = scriptablestates[index];
                level thread setstate(scriptablename, scriptablestate);
              }

              index++;
              continue;
            }

            scriptablestate = sstate[1];
            level thread setstate(scriptablename, scriptablestate);
          }
        }
      }
    }
  }
}

function private freescriptables() {
  foreach(scriptable in level.scriptables) {
    scriptable.scriptable freescriptable();
  }

  level.var_8210ecbe0122c3c1 = 0;
}

function private function_a371140c854c137c() {
  if(isDefined(level.scriptables)) {
    foreach(scriptablename, scriptable in level.scriptables) {
      scriptable["scriptable"] setscriptablepartstate(scriptablename, "visible");
    }
  }
}

function private function_577a224b91899036(index, scriptabledata) {
  if(!level.var_8210ecbe0122c3c1) {
    level.var_8210ecbe0122c3c1 = 1;
  }

  if(!isDefined(scriptabledata.origin)) {
    println("<dev string:x89>");
  }

  origin = (scriptabledata.origin.x, scriptabledata.origin.y, scriptabledata.origin.z);
  angles = (scriptabledata.angles.x, scriptabledata.angles.y, scriptabledata.angles.z);
  scriptable = spawnscriptable(scriptabledata.scriptable, origin, angles);
  scriptable.triggerindex = index;
  level.scriptables[scriptabledata.scriptable] = [];
  level.scriptables[scriptabledata.scriptable]["scriptable"] = scriptable;
  scriptable::scriptable_addusedcallbackbypart(scriptabledata.scriptable, &function_59c3f2207c0c8735);
}

function private function_33f865680e2b80aa(index, trigger) {
  level.var_e15cbf88b9bdcd36[trigger.var_52f74fb9e50415ca] = [];
  level.var_e15cbf88b9bdcd36[trigger.var_52f74fb9e50415ca]["index"] = index;
  level.var_e15cbf88b9bdcd36[trigger.var_52f74fb9e50415ca]["hintString"] = trigger.hintstring;
  var_48fd1ee9c66e1448 = trigger.var_48fd1ee9c66e1448;
  triggerent = frontendutils::function_28d43ffc378eedeb(var_48fd1ee9c66e1448);

  if(isDefined(triggerent)) {
    triggerent.var_33f76c2d569e4abf = 0;
    triggerent.triggerindex = index;
    triggerhint = spawn("script_origin", triggerent.origin);
    triggerhint makeusable();
    triggerhintstring = level.var_e15cbf88b9bdcd36[triggerent.script_noteworthy]["hintString"];

    if(isDefined(triggerhintstring)) {
      triggerhint setHintString(triggerhintstring);
      triggerhint sethintdisplayrange(55);
      triggerhint setuserange(55);
      triggerhint setCursorHint("hint_noicon");
      triggerhint sethintonobstruction("show");
    }

    triggerent thread function_e18f0c39f1cd958d(self);
  }
}

function private function_6824b990b7a1ad67(index, modeldata) {
  level.models[modeldata.var_52f74fb9e50415ca] = [];
  level.models[modeldata.var_52f74fb9e50415ca]["index"] = index;
  level.var_3a0027efc54b67b0[modeldata.var_52f74fb9e50415ca]["hintString"] = modeldata.hintstring;
  origin = (modeldata.origin.x, modeldata.origin.y, modeldata.origin.z);
  angles = (modeldata.angles.x, modeldata.angles.y, modeldata.angles.z);
  model = spawn("script_model", origin, angles);
  model setModel(modeldata.model);
  model.triggerindex = index;
  model makeusable();
  triggerhintstring = modeldata.hintstring;

  if(isDefined(triggerhintstring)) {
    model setHintString(triggerhintstring);
    model sethintdisplayrange(55);
    model setuserange(55);
    model setCursorHint("hint_noicon");
    model sethintonobstruction("show");
  }

  model thread function_e18f0c39f1cd958d(self);
}

function private function_9041fe4c904cfed5() {
  sceneinteractables = getgamemodescriptbundle().triggersetup;

  if(isDefined(sceneinteractables)) {
    interactables = getscriptbundle(sceneinteractables);

    if(isDefined(interactables)) {
      if(!isDefined(level.var_e15cbf88b9bdcd36)) {
        level.var_e15cbf88b9bdcd36 = [];
        level.scriptables = [];
        level.models = [];
      }

      index = 1;

      foreach(interactable in interactables.triggerdata) {
        if(isDefined(interactable.scriptable) && interactable.scriptable != "") {
          function_577a224b91899036(index, interactable);
        } else if(isDefined(interactable.model) && interactable.model != "") {
          function_6824b990b7a1ad67(index, interactable);
        } else if(isDefined(interactable.var_48fd1ee9c66e1448)) {
          function_33f865680e2b80aa(index, interactable);
        } else {
          println("<dev string:xc4>");
        }

        index++;
      }
    }
  }
}

function function_867cd6025b5f3ea7(var_1d92d20a5f2943f7) {
  function_95437b3e5726ad89();
  level.var_84937cfb956d7c1d = (var_1d92d20a5f2943f7 & 1) == 1;
  println("<dev string:x128>");
  suitname = utility::function_f825237e0eda5adf();
  self setsuit(suitname);
  println("<dev string:x138>");
  self.sessionstate = "playing";
  self.statusicon = "";
  waitframe();
  self.settospectate = 0;
  frontend_spawnplayer();
  function_9041fe4c904cfed5();
  function_a371140c854c137c();
  function_6962d43f0cfea5ad();
}

function function_d86b6171373c7132(settospectate) {
  level.var_9a9e574f38255764 = 1;

  if(settospectate) {
    wait 1;
    function_fd048ed205a845();
    wait 1;
    self.sessionstate = "spectator";
    self allowspectateteam("none", 1);
    self.settospectate = 1;
    self cameralinkTo(level.camera_anchor, "tag_origin");
    function_9f6834cdc0c1becc();
  } else {
    function_d93dc0e30142bc0a();
  }

  level.var_9a9e574f38255764 = 0;
}

function function_4ca96946a95337ad(var_e1c871cf960be778) {
  level.var_9a9e574f38255764 = 1;

  if(self.settospectate) {
    function_95437b3e5726ad89();
  } else {
    function_fdd6e9ab83afde9();
  }

  namespace_285f2d8d2827221c::update_player_weapon();
  self cameraunlink(self.camera_anchor);
  wait 0.1;

  if(var_e1c871cf960be778) {
    self.sessionstate = "playing";
    self.statusicon = "";
    self.settospectate = 0;
  }

  level.var_9a9e574f38255764 = 0;
}

function function_e18f0c39f1cd958d(player) {
  while(true) {
    if(!self.var_33f76c2d569e4abf) {
      self waittill("trigger");
      self.var_33f76c2d569e4abf = 1;

      if(self.script_noteworthy == "shootingrange") {
        entered_firing_range = 1;
        function_9b59870a39f03b40(player);
      }

      setomnvar("ui_walkable_scene_trigger_index", self.triggerindex);
      continue;
    }

    if(self istouching(player)) {
      waitframe();
      continue;
    }

    if(self.script_noteworthy == "shootingrange" && entered_firing_range) {
      entered_firing_range = 0;
      function_6c0406dc8b2329ae(player);
    }

    self.var_33f76c2d569e4abf = 0;
    setomnvar("ui_walkable_scene_trigger_index", -1);
  }
}

function function_9b59870a39f03b40(player) {
  player setcamerathirdperson(0);
  function_2a0ac7d9080f76f(player, 1);
}

function function_6c0406dc8b2329ae(player) {
  player setcamerathirdperson(1);
  function_2a0ac7d9080f76f(player, 0);
}

function function_975c17bde7e82d6() {
  self.settospectate = 1;
  self setcamerathirdperson(0);
  self clearclienttriggeraudiozone(2);
  function_fd048ed205a845();
  self suicide();
  waitframe();
  self allowspectateteam("none", 1);
  self.sessionstate = "spectator";
}

function function_1b6fa013c0c2b251(newlootid) {
  function_9dadf27bbe1eeff0();

  if(newlootid == 0) {
    newlootid = level.var_faaa844cfeb8273e;
  }

  if(self.var_dbb03d2597689cae == newlootid) {
    return;
  }

  self.var_dbb03d2597689cae = newlootid;

  if(!level.var_7d880106a79112ae[newlootid]) {
    assertmsg("<dev string:x15b>" + newlootid);
    return;
  }

  xmodel = level.var_7d880106a79112ae[newlootid].var_ab2df660ca22b8c5;
  backpack::attachbag(xmodel);
}

function private function_9dadf27bbe1eeff0() {
  if(level.var_7d880106a79112ae) {
    return;
  }

  level.var_7d880106a79112ae = [];
  backpacklist = undefined;

  foreach(entry in level.gametypebundle.itemspawnlistrefs) {
    if(entry.ref == "BACKPACKS") {
      backpacklist = getscriptbundle(entry.list);
      break;
    }
  }

  if(!backpacklist) {
    assertmsg("<dev string:x18e>");
    return;
  }

  foreach(entry in backpacklist.itementries) {
    itembundle = getscriptbundlefieldvalues(getxhashasset(entry.itemspawnentry), [#"ref", #"hash_146dd41e6d0c890c", #"isbasebackpack"]);
    lootinfo = getLootItemInfoFromRef(itembundle.ref);

    if(!lootinfo.itemid) {
      continue;
    }

    if(itembundle.isbasebackpack) {
      level.var_faaa844cfeb8273e = lootinfo.itemid;
    }

    level.var_7d880106a79112ae[lootinfo.itemid] = itembundle;
  }
}

function function_b01ea89ac6576abd() {
  function_975c17bde7e82d6();

  if(isDefined(level.camera_loadout_showcase_overview)) {
    self setspectatedefaults(level.camera_loadout_showcase_overview.basecam.origin, level.camera_loadout_showcase_overview.basecam.angles);
  }

  if(isDefined(self.camera_anchor)) {
    self cameralinkTo(level.camera_anchor, "tag_origin");
  }

  waitframe();
  function_9f6834cdc0c1becc();
  freescriptables();
  level notify("exit_firing_range");
}

function private infiniteammo() {
  self notify("83881c773b009b46");
  self endon("83881c773b009b46");
  level endon("exit_firing_range");

  while(true) {
    weapons = self getweaponslistprimaries();

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammostock(weapon, weaponmaxammo(weapon));
    }

    waitframe();
  }
}
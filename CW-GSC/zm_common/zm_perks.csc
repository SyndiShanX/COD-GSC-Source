/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_perks.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#namespace zm_perks;

function init() {
  if(!isDefined(level.var_c3e5c4cd)) {
    level.var_c3e5c4cd = zm_utility::get_story();
  }

  callback::on_start_gametype(&init_perk_machines_fx);
  init_custom_perks();
  perks_register_clientfield();
  init_perk_custom_threads();
}

function function_f3c80d73(str_bottle, str_totem) {
  if(zm_utility::get_story() == 1 || !isDefined(str_totem)) {
    w_perk = getweapon(str_bottle);
  } else {
    w_perk = getweapon(str_totem);
  }

  forcestreamxmodel(w_perk.viewmodel, -1, -1);
  forcestreamxmodel(w_perk.worldmodel, 1, 1);
}

function perks_register_clientfield() {
  if(is_true(level.zombiemode_using_perk_intro_fx)) {
    clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int", &perk_meteor_fx, 0, 0);
  }

  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].clientfield_register)) {
        level[[level._custom_perks[a_keys[i]].clientfield_register]]();
      }
    }
  }
}

function function_89e748a7() {
  for(i = 0; i < 4; i++) {
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".itemIndex", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"itemindex"], 1, 5, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".state", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"state"], 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".progress", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"progress"], 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".chargeCount", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"chargecount"], 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".timerActive", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"timeractive"], 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutOrderIndex", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"bleedoutorderindex"], 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutActive", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"bleedoutactive"], 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".specialEffectActive", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"specialeffectactive"], 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".modifierActive", #"hash_5d152bf7cbeda3ad", [hash(isDefined(i) ? "" + i : ""), #"modifieractive"], 6000, 1, "int", undefined, 0, 0);
  }

  clientfield::register_clientuimodel("hudItems.perkVapor.bleedoutProgress", #"hash_5d152bf7cbeda3ad", #"bleedoutprogress", 9000, 8, "float", undefined, 0, 0);

  for(i = 0; i < 9; i++) {
    n_version = 1;

    if(i >= 4) {
      n_version = 8000;
    }

    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".itemIndex", #"hash_77ee4bf4c3af9d1c", [hash(isDefined(i) ? "" + i : ""), #"itemindex"], n_version, 5, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".state", #"hash_77ee4bf4c3af9d1c", [hash(isDefined(i) ? "" + i : ""), #"state"], n_version, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".progress", #"hash_77ee4bf4c3af9d1c", [hash(isDefined(i) ? "" + i : ""), #"progress"], n_version, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".chargeCount", #"hash_77ee4bf4c3af9d1c", [hash(isDefined(i) ? "" + i : ""), #"chargecount"], n_version, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".timerActive", #"hash_77ee4bf4c3af9d1c", [hash(isDefined(i) ? "" + i : ""), #"timeractive"], n_version, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".specialEffectActive", #"hash_77ee4bf4c3af9d1c", [hash(isDefined(i) ? "" + i : ""), #"specialeffectactive"], n_version, 1, "int", undefined, 0, 0);
  }

  if(level.var_c3e5c4cd == 2) {
    clientfield::register("world", "" + # "hash_46334db9e3c76275", 1, 1, "int", &function_9b4bc8e7, 0, 0);
    clientfield::register("scriptmover", "" + # "hash_50eb488e58f66198", 1, 1, "int", &function_52c149b2, 0, 0);
    clientfield::register("allplayers", "" + # "hash_222c3403d2641ea6", 1, 3, "int", &function_ab7cd429, 0, 0);
    clientfield::register("toplayer", "" + # "hash_17283692696da23b", 1, 1, "counter", &function_ccbdf992, 0, 0);
  }

  level thread perk_init_code_callbacks();
}

function perk_init_code_callbacks() {
  wait 0.1;

  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].clientfield_code_callback)) {
        level[[level._custom_perks[a_keys[i]].clientfield_code_callback]]();
      }
    }
  }
}

function init_custom_perks() {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }
}

function register_perk_clientfields(str_perk, func_clientfield_register, func_code_callback) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
  level._custom_perks[str_perk].clientfield_code_callback = func_code_callback;
}

function register_perk_effects(str_perk, str_light_effect) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].machine_light_effect = str_light_effect;
}

function register_perk_init_thread(str_perk, func_init_thread) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].init_thread = func_init_thread;
}

function function_b60f4a9f(str_perk, var_4fbc4ea9, var_347c72d2, var_51f1a532) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].var_4fbc4ea9 = var_4fbc4ea9;
  level._custom_perks[str_perk].var_347c72d2 = var_347c72d2;

  if(isDefined(var_51f1a532)) {
    level._custom_perks[str_perk].var_51f1a532 = var_51f1a532;
  }
}

function init_perk_custom_threads() {
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].init_thread)) {
        level thread[[level._custom_perks[a_keys[i]].init_thread]]();
      }
    }
  }
}

function _register_undefined_perk(str_perk) {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }

  if(!isDefined(level._custom_perks[str_perk])) {
    level._custom_perks[str_perk] = spawnStruct();
  }
}

function perk_meteor_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.meteor_fx = util::playFXOnTag(fieldname, level._effect[#"perk_meteor"], self, "tag_origin");
    return;
  }

  if(isDefined(self.meteor_fx)) {
    stopfx(fieldname, self.meteor_fx);
  }
}

function init_perk_machines_fx(localclientnum) {
  if(!level.enable_magic) {
    return;
  }

  wait 0.1;
  machines = struct::get_array("zm_perk_machine", "targetname");
  array::thread_all(machines, &perk_start_up);
}

function perk_start_up() {
  if(isDefined(self.script_int)) {
    power_zone = self.script_int;

    for(int = undefined; int != power_zone; int = waitresult.is_on) {
      waitresult = level waittill(#"power_on");
    }
  } else {
    level waittill(#"power_on");
  }

  timer = 0;
  duration = 0.1;

  while(true) {
    if(isDefined(level._custom_perks[self.script_noteworthy]) && isDefined(level._custom_perks[self.script_noteworthy].machine_light_effect)) {
      self thread vending_machine_flicker_light(level._custom_perks[self.script_noteworthy].machine_light_effect, duration);
    }

    timer += duration;
    duration += 0.2;

    if(timer >= 3) {
      break;
    }

    wait duration;
  }
}

function vending_machine_flicker_light(fx_light, duration) {
  players = level.localplayers;

  for(i = 0; i < players.size; i++) {
    self thread play_perk_fx_on_client(i, fx_light, duration);
  }
}

function play_perk_fx_on_client(client_num, fx_light, duration) {
  fxobj = spawn(client_num, self.origin + (0, 0, -50), "script_model");
  fxobj setModel(#"tag_origin");
  util::playFXOnTag(client_num, level._effect[fx_light], fxobj, "tag_origin");
  wait duration;
  fxobj delete();
}

function function_ccbdf992(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrenderoverridebundle(#"hash_4659ecede94f0b38", "tag_accessory_left");
  }
}

function function_35ba0b0e(localclientnum, n_slot) {
  level endon(#"demo_jump");
  self endon(#"death");
  self zm_loadout::function_622d8349(localclientnum);
  n_perk = n_slot + 1;
  var_3e311473 = self zm_loadout::get_loadout_item(localclientnum, "specialty" + n_perk);

  if(!isDefined(var_3e311473)) {
    return;
  }

  s_perk = getunlockableiteminfofromindex(var_3e311473, 3);

  if(!isDefined(s_perk) || !isDefined(s_perk.specialties) || !isDefined(s_perk.specialties[0])) {
    return;
  }

  str_perk = s_perk.specialties[0];

  if(isstring(str_perk)) {
    var_16c042b8 = hash(str_perk);
  }

  return var_16c042b8;
}

function function_5b123b68(localclientnum, b_show, b_use_offset = 0) {
  if(isDefined(self.var_d67a4862)) {
    stopfx(localclientnum, self.var_d67a4862);
  }

  if(b_show) {
    v_angles = self gettagangles("fx_tag_base_emblem");
    v_origin = self gettagorigin("fx_tag_base_emblem");

    if(b_use_offset && isDefined(self.var_7ad76c54)) {
      v_origin -= anglesToForward(v_angles) * self.var_7ad76c54;
    }

    self.var_d67a4862 = playFX(localclientnum, self.var_be82764e, v_origin, anglesToForward(v_angles));
    return;
  }

  self.var_d67a4862 = undefined;
}

function private function_be3ae9c5(n_value, var_51e3f61d = 0) {
  if(n_value < 5) {
    if(var_51e3f61d && n_value == 0) {
      return true;
    }

    return false;
  }

  return true;
}

function function_9b4bc8e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"demo_jump");

  if(bwastimejump) {
    while(!isDefined(level.var_aaf8da70)) {
      waitframe(1);
      level.var_aaf8da70 = getent(fieldname, "zeus_bird_head", "targetname");
    }

    util::playFXOnTag(fieldname, level._effect[#"hash_46334db9e3c76275"], level.var_aaf8da70, "bird_follow_jnt");
    level.var_aaf8da70 thread function_6a0a572d(fieldname);
  }
}

function function_6a0a572d(localclientnum) {
  level endon(#"demo_jump");
  self endon(#"death");

  while(true) {
    wait randomintrange(5, 20);
    self playSound(localclientnum, #"hash_62f87027921fa5b4");
  }
}

function function_52c149b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(level.var_aaf8da70)) {
      level.var_aaf8da70 = util::spawn_model(fieldname, "p8_fxanim_zm_vapor_altar_zeus_bird_head_mod", self gettagorigin("tag_bird_head"), self gettagangles("tag_bird_head"));
      level.var_aaf8da70.targetname = "zeus_bird_head";
    }
  }
}

function function_ab7cd429(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"demo_jump");

  if(!isDefined(level.var_aaf8da70)) {
    level.var_aaf8da70 = getent(fieldname, "zeus_bird_head", "targetname");
  }

  var_aaf8da70 = level.var_aaf8da70;

  if(!isDefined(var_aaf8da70)) {
    return;
  }

  var_aaf8da70 endon(#"death");

  if(!isDefined(level.var_245eb09f)) {
    level.var_245eb09f = var_aaf8da70.angles;

    if(level.var_245eb09f[1] == 360) {
      level.var_245eb09f = (0, 0, 0);
    }
  }

  level notify(#"hash_4d8d403fdb281b69");
  wait 0.5;

  if(bwastimejump == 0) {
    var_6d877f48 = array::random(array((7, 7, 7), (-7, -7, -7), (-7, 7, 7), (7, -7, -7)));
    var_aaf8da70 rotateto(level.var_245eb09f + var_6d877f48, 0.2);
    wait 0.8;
    var_aaf8da70 rotateto(level.var_245eb09f, 0.1);
    return;
  }

  var_165f12bb = array::random(array((17, 30, 25), (-10, -30, -25), (-10, 30, 25), (17, -30, -25)));
  var_aaf8da70 rotateto(level.var_245eb09f + var_165f12bb, 0.15);
  var_aaf8da70 thread function_1625e105(self);
}

function function_1625e105(e_player) {
  if(!isDefined(e_player)) {
    return;
  }

  level endon(#"demo_jump", #"hash_4d8d403fdb281b69");
  e_player endon(#"death");
  self endon(#"death");
  wait 1;

  while(isDefined(e_player)) {
    var_d1d1cc92 = e_player gettagorigin("j_head");

    if(!isDefined(var_d1d1cc92)) {
      var_d1d1cc92 = e_player.origin;
    }

    if(vectordot(vectornormalize(var_d1d1cc92 - self.origin), anglesToForward(level.var_245eb09f)) > 0.5) {
      var_a8dcfa = vectortoangles(var_d1d1cc92 - self.origin);
      self rotateto(var_a8dcfa, 0.15);
    }

    wait 0.15;
  }
}
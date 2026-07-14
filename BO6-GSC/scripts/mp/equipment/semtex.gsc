/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\equipment\semtex.gsc
*******************************************/

#using script_1adabd4beb172de7;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\weapons;
#namespace semtex;

function private autoexec function_2e156f7b4a6033d3() {
  level callback::add("init_grenade", &init);
}

function private init(params) {
  weapons::registerusedcallback("semtex", &semtex_used);
  weapons::function_2cd25260a11d5e40("semtex", &semtex_pullback);
}

function semtex_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  bundle = equipment::getequipmenttableinfo("equip_semtex").bundle;

  if(bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash(bundle.var_e36b84555e7df1d3)) {
    if(self.semtexsoundent) {
      self.semtexsoundent unlink();
      self.semtexsoundent linkTo(grenade, "tag_origin", (0, 0, 0), (0, 0, 0));
    }

    grenade setscriptablepartstate(#"state", #"warning_without_sound", 0);
  }

  grenade.bundle = equipment::getEquipmentBundleFromWeaponName(grenade.weapon_name);
  grenade thread weapons::delayshow(0.05);
  stuckinfo = grenade weapons::function_f38c6bdea2fb97f3(1, grenade.bundle.var_21c82f0c7a81799c);

  if(stuckinfo) {
    if(stuckinfo.msg == "missile_stuck") {
      stuckto = stuckinfo.param1;
    }
  }

  if(!(bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash(bundle.var_e36b84555e7df1d3))) {
    grenade setscriptablepartstate(#"state", #"warning", 0);
  }

  if(isPlayer(stuckto) || isagent(stuckto)) {
    thread namespace_2c42f1b7d9a6dd72::threadedsetweaponstatbyname(grenade.weapon_object, 1, "special_hits");
    var_7f3fdce4d25dd061 = weapon_utility::function_7f3fdce4d25dd061(grenade);

    if(!(bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash(bundle.var_e36b84555e7df1d3))) {
      stuckto playlocalsound(grenade.bundle.var_a65332982b86adce ?? #"hash_d0bafe992c88665d");
    }

    weapons::grenadestuckto(grenade, stuckto, 0, var_7f3fdce4d25dd061);

    if(isagent(stuckto)) {
      if(level.battlechatter) {
        addbattlechatternotify(stuckto, undefined, "semtex_stuck");
      } else {
        stuckto setbattlechatterflag("semtex_stuck", 3);
      }
    }

    if(isagent(stuckto) && !stuckto.var_2f7b28254901f8d6) {
      if(!stuckto.var_f424a6135c1dd01f) {
        stuckto.var_f424a6135c1dd01f = [];
      } else {
        stuckto.var_f424a6135c1dd01f = function_46f9072493651dc9(stuckto.var_f424a6135c1dd01f);
      }

      stuckto.var_f424a6135c1dd01f[stuckto.var_f424a6135c1dd01f.size] = grenade;
      assert(stuckto.health > 0, "<dev string:x24>");
      ai::function_9b5d55d642edff87(grenade, stuckto);
    }
  }

  if(level.var_ff28e0c14ba90179) {
    foreach(var_13edf91f5c68cd04 in level.var_ff28e0c14ba90179) {
      var_13edf91f5c68cd04 thread utility::function_f6d2b1924fca249(grenade);
    }
  }
}

function semtex_pullback(params) {
  bundle = equipment::getequipmenttableinfo("equip_semtex").bundle;

  if(bundle.var_e36b84555e7df1d3 && equipment_mp::function_e6b75548c2c3c6cf("equip_semtex", bundle.var_e36b84555e7df1d3)) {
    self.semtexsoundent = spawn("script_model", self.origin);
    self.semtexsoundent.owner = self;
    self.semtexsoundent linkTo(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    wait 0.45;
    soundalias = bundle.var_a65332982b86adce ?? #"hash_d0bafe992c88665d";
    self.semtexsoundent playsoundonmovingent(soundalias);
    self.semtexsoundent thread function_7d673aebc25b92b3((lookupsoundlength(soundalias) ?? 1000) * 0.001);
  }
}

function private function_7d673aebc25b92b3(time) {
  self notify("10b15992cac525c4");
  self endon("10b15992cac525c4");
  wait time;

  if(self.owner) {
    self.owner.semtexsoundent = undefined;
  }

  if(self) {
    self delete();
  }
}
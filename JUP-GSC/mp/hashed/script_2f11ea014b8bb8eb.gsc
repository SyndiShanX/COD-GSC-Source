/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f11ea014b8bb8eb.gsc
*************************************************/

#using script_21c19cfc7139d773;
#using script_22856b83897eaad8;
#using script_64acb6ce534155b7;
#using script_7c875a4a27280806;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_kiosk;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#using scripts\ob\points;
#namespace ob_laststand;

function function_77d7e4f0ae4fa9be() {
  callback::add("player_death", &on_player_death);
  callback::add("player_spawned", &on_player_spawn);
  callback::add("player_laststand", &on_player_laststand);
  callback::add("player_revived", &on_player_revived);
  callback::add("player_connect", &on_player_connect);
  callback::add("player_disconnect", &on_player_disconnect);
  callback::add("bleedout_tick", &function_59bb85cf2b5af12f);
  callback::add("player_bleedout", &on_player_bleedout);
  level.var_2d3ee92902ba30fa = &scripts\cp_mp\laststand::laststandthink;
  level.var_b57e01a4f8558a6b = &function_8d9342e5f3da44a;
  level.var_a32cddb0c46cead7 = getdvarint(@ "hash_d6c686e2745925e3", 0);
  level.var_d9a236c9a5ac921e = !level.var_a32cddb0c46cead7;
  level.var_8b2457623e1802dc = &function_1867a137f8974cd9;
  level.modeonlaststandfunc = &function_d564d036834cc766;
  level.modeonexitlaststandfunc = &function_144b0ea22640fc8e;
  level.modelaststandallowed = &function_e3a66691f547f69d;
  level.modeplayerkilledspawn = &function_be83ba972fd71c80;
  level.var_83ed94a4c034a642 = &function_21773d54ce6837b2;
  level.removeselfrevivetoken = &scripts\cp_mp\laststand::function_d7827c7865b2089b;
  level.var_8ef6408ea14287af = 1;
  level.var_cfbe6af2219da1dc = &function_baa9acb14150c174;
  level.var_290b75900d1fff6 = 1;
  level.var_c53947782c7460f6 = 1;
  level.var_9039ba619a4ab3e1 = getdvarint(@ "hash_eabfa08be1d07d87", 1);
  level.var_6d63cbd43e47315e = 1;
  level.var_c0c96e1450994eaf = &function_133892d59b149cce;
  level.var_a52a7cf832d13dad = getdvarint(@ "hash_e05251a329fd0d9d", 1);
  level.var_520545ce455767b6 = 1;
  level.addlaststandoverheadiconcallback = &void;
  level.var_2d3f190c222f8218 = 1;
  level.var_8868d59e008df32d = &function_8868d59e008df32d;
  val::group_register("laststand_ob_values", ["usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons"]);
  level.customlaststandactionset = "laststand_ob_values";
  level.var_6d368866ba58bb04 = &function_493ca4f5db3e7909;
}

function function_e3a66691f547f69d(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(attacker) && attacker scripts\common\vehicle::ishelicopter() && smeansofdeath == "MOD_CRUSH") {
    return true;
  }

  return true;
}

function on_player_connect(params) {
  thread function_dbc4f2e956dc67dd();
}

function on_player_disconnect(params) {
  if(isDefined(self.var_9bfbbff8982fc132)) {
    self.var_9bfbbff8982fc132 delete();
  }

  thread check_self_revive_for_hotjoin(params);
  thread ob_laststand_alive_check(0);
}

function function_baa9acb14150c174() {
  usetime = 3000;
  return usetime;
}

function function_dbc4f2e956dc67dd() {
  self endon("disconnect");
  scripts\cp_mp\laststand::function_188085b8b8d431f2(0);
  self.var_18445effcf1ebc1b = 0;
  self.var_dddc97480e104865 = level.gametypebundle.var_7414261752817c0;
  self.var_60a26e89bc2c7157 = level.gametypebundle.var_26cb68d514ad2106;
  thread check_self_revive_for_hotjoin();
  self waittill("spawned_player");
  var_c9b69aecc5c631ed = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(var_c9b69aecc5c631ed.size == 1) {
    scripts\cp_mp\laststand::function_188085b8b8d431f2(self.var_dddc97480e104865);

    if(scripts\cp_mp\laststand::function_546201bb34cf36ce() > 0) {
      self.var_270b950ef70147b0 = 1;
    }

    return;
  }

  scripts\cp_mp\laststand::function_188085b8b8d431f2(self.var_60a26e89bc2c7157);
}

function check_self_revive_for_hotjoin(params) {
  level notify("notify_check_self_revive_for_hotjoin");
  level endon("notify_check_self_revive_for_hotjoin");
  var_c9b69aecc5c631ed = scripts\cp_mp\utility\squad_utility::getsquadmembers();
  var_3f3e4fdf36764c05 = 0;
  var_466b7f820541a117 = 0;
  waitframe();
  var_c9b69aecc5c631ed = array_removeundefined(var_c9b69aecc5c631ed);

  if(var_c9b69aecc5c631ed.size == 1) {
    var_3f3e4fdf36764c05 = 1;

    foreach(player in var_c9b69aecc5c631ed) {
      if(!player ent_flag("solo_game")) {
        var_466b7f820541a117 = 1;
        player ent_flag_set("solo_game");
      }
    }
  } else {
    foreach(player in var_c9b69aecc5c631ed) {
      if(player ent_flag("solo_game")) {
        var_466b7f820541a117 = 1;
        player ent_flag_clear("solo_game");
      }
    }
  }

  if(var_466b7f820541a117) {
    foreach(player in var_c9b69aecc5c631ed) {
      if(istrue(player.var_270b950ef70147b0)) {
        if(var_3f3e4fdf36764c05) {
          if(player scripts\cp_mp\laststand::function_546201bb34cf36ce() <= 0) {
            player scripts\cp_mp\laststand::function_188085b8b8d431f2(int(max(0, player.var_dddc97480e104865 - player.var_18445effcf1ebc1b)));
          }

          continue;
        }

        player scripts\cp_mp\laststand::function_188085b8b8d431f2(int(max(0, player.var_60a26e89bc2c7157 - player.var_18445effcf1ebc1b)));
        player ent_flag_clear("solo_game");
      }
    }
  }
}

function function_8d9342e5f3da44a() {
  thread scripts\cp_mp\laststand::bleedoutthink();

  if(scripts\cp_mp\laststand::function_546201bb34cf36ce() <= 0) {
    thread scripts\cp_mp\laststand::suicidesetup();
  }

  if(getdvarint(@ "hash_fc9bc06d7d582da9", 0)) {
    val::set("ob_laststand", "damage", 0);
  }

  val::set("ob_laststand", "ignoreme", 1);
  waittill_any_ents(self, "death_or_disconnect", self, "last_stand_finished", level, "game_ended");

  if(!isDefined(self)) {
    return;
  }

  self.var_642c536e9ce4a2ec = 1;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self forceusehintoff();
  ignoretimer = getdvarint(@ "hash_b04b0a31679d1435", 3);

  if(isDefined(self.var_15e233396dbbe296)) {
    ignoretimer = self.var_15e233396dbbe296;
  }

  if(ignoretimer > 0) {
    wait ignoretimer;
  }

  if(isDefined(self)) {
    val::reset_all("ob_laststand");
  }
}

function function_133892d59b149cce() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  self sethidenameplate(0);
  self.healthregendisabled = 0;
  self.liveragdoll = 0;
  stopspectateplayer(self getentitynumber(), 1, 0);
  updatesessionstate("playing");
  self setsolid(1);
  self function_6b4c8718bc36d1ef(0);
  self function_e4ccd01fb7ec7a6f(0);
  self stopliveragdoll();
  _freezecontrols(0, undefined, "liveRagdoll");
  scripts\mp\class::setthirdpersonview();
  self.var_6c0f9f7e906a5ee6 = 1;
  self.setspawnpoint = undefined;
  self.forcespawnorigin = self.var_d82ef0f535aa42fb;
  scripts\mp\playerlogic::spawnclient(1);
  self dontinterpolate();
  v_spawn = getgroundposition(self.var_d82ef0f535aa42fb, 16);
  v_spawn = isDefined(v_spawn) ? v_spawn : self.var_d82ef0f535aa42fb;
  self setOrigin(v_spawn + (0, 0, 4));
  self.var_d82ef0f535aa42fb = undefined;
  scripts\ob\points::function_d57de844b62e642b();

  if(istrue(self.var_28c033c3c5b37f1f)) {
    namespace_c7a286c0a621f184::set_golden_armor();
  }
}

function on_player_bleedout(params) {
  if(!isPlayer(self) || self.sessionstate == "intermission") {
    return;
  }

  self endon("disconnect");
  updatesessionstate("playing");
  _freezecontrols(1, undefined, "liveRagdoll");
  self sethidenameplate(1);
  self.healthregendisabled = 1;
  self.liveragdoll = 1;
  self setsolid(0);
  self function_6b4c8718bc36d1ef(1);
  self function_e4ccd01fb7ec7a6f(1);
  self startliveragdoll();
  scripts\mp\class::setthirdpersonview();
  self.var_d82ef0f535aa42fb = self.origin;
}

function on_player_death(params) {
  self.br_iseliminated = 1;
  scripts\mp\gametypes\br_public::setplayerdownedextrainfo(0);
  scripts\mp\gametypes\br_utility::updateplayereliminatedomnvar();
  val::set("ob_death", "ignoreme", 1);
  scripts\ob\points::function_5ef7bc993b154224();

  if(isDefined(params.inflictor) && isDefined(params.attacker)) {
    self lookatkiller(params.inflictor, params.attacker);
  }

  self setclientomnvar("ui_br_inventory_disabled", 1);
  thread ob_laststand_alive_check(0);
}

function function_21773d54ce6837b2(corpse, animduration) {
  self endon("disconnect");
  corpse endon("death");
  self waittill("spawned_player");
  corpse delete();
}

function function_be83ba972fd71c80(deathdata, finaldeath) {
  deathdata.victim val::set("ob_death", "ignoreme", 1);

  if(!istrue(level.gameended) && !istrue(deathdata.victim.liveragdoll)) {
    deathdata.victim namespace_7177e11e3871c8f4::take_juggernaut_perk();
    deathdata.victim delaythread(0.1, &scripts\mp\playerlogic::spawnspectator);
    deathdata.victim scripts\mp\utility\lower_message::setlowermessageomnvar("br_standby_for_respawn");
  }

  deathdata.victim callback::callback("on_ob_laststand_player_killed", deathdata);
  return true;
}

function function_6040f7fbe4b91c73() {
  self endon("disconnect");
  wait 0.15;
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.primaryweapons[0]);
}

function on_player_spawn(params) {
  self endon("disconnect");

  if(!istrue(level.gameended)) {
    val::reset("ob_death", "ignoreme");
  }

  if(istrue(self.br_iseliminated)) {
    self.var_b6c4b0b7ace6006e = undefined;

    if(!scripts\mp\utility\game::isteamreviveenabled()) {
      waitframe();

      foreach(weapon in self.primaryweapons) {
        self givemaxammo(weapon);
        self setweaponammoclip(weapon, weaponclipsize(weapon));
      }
    }
  }

  if(isDefined(self.var_9bfbbff8982fc132)) {
    self.var_9bfbbff8982fc132 delete();
  }

  self.br_iseliminated = undefined;
  self.healthregendisabled = undefined;
  self.liveragdoll = 0;
  self.squadwiped = undefined;
  scripts\mp\gametypes\br_utility::updateplayereliminatedomnvar();
  scripts\mp\gametypes\br_public::setplayerdownedextrainfo(0);
  scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo(0);
  scripts\mp\gametypes\br::updatesquadmemberlaststandreviveprogress(self, self, 0, 1);
  self setclientomnvar("ui_br_inventory_disabled", 0);

  if(!istrue(self.var_69bf698c4fd8a446)) {
    if(isbot(self)) {
      self endon("<dev string:x1c>");
      wait 4;
    }

    self.var_69bf698c4fd8a446 = 1;
    function_6e7290c8ee4f558b("<dev string:x33>");
    function_b23a59dfb4ca49a1(self.name, "<dev string:x55>" + self.name, &function_6cc14e0f7058fbf4);
    function_fe953f000498048f();
  }
}

function on_player_laststand(params) {
  thread scripts\mp\gametypes\br_public::setplayerdownedextrainfo(1);
  self.var_64a7c6d08000be36 = self.primaryweapons;
  self.var_b43e8623c0dd6a67 = self getcurrentweapon();

  if(isDefined(self.var_b43e8623c0dd6a67) && !weapon::iscacprimaryorsecondary(self.var_b43e8623c0dd6a67) && !weapon::isfistsonly(self.var_b43e8623c0dd6a67)) {
    self.var_b43e8623c0dd6a67 = undefined;
  }

  var_c9b69aecc5c631ed = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(squad_member in var_c9b69aecc5c631ed) {
    if(!isDefined(squad_member) || squad_member == self) {
      continue;
    }

    squad_member thread scripts\mp\hud_message::showsplash("br_teammate_down", undefined, self);
    squad_member thread namespace_88bfae359020fdd3::function_4e19e6bf429dda56(self);
  }
}

function on_player_revived(params) {
  scripts\mp\gametypes\br_public::setplayerdownedextrainfo(0);
  self endon("death_or_disconnect");
  wait 0.25;
  self.maxhealth = int(max(level.laststandrevivehealth, self.maxhealth));
  self.health = self.maxhealth;
}

function function_6cc14e0f7058fbf4(params) {
  var_3352bf952cfc182a = params[0];

  foreach(player in level.players) {
    if(isDefined(var_3352bf952cfc182a) && player.name == var_3352bf952cfc182a) {
      player thread function_ef6adc9492d03ef(player.origin);
      break;
    }
  }
}

function function_1867a137f8974cd9() {
  var_e5ca507329f88439 = [];
  weaponlist = self.primaryweapons;
  w_laststand = getDvar(@ "hash_2c3222a73adb30fd", "iw9_me_fists_mp");
  w_laststand = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(w_laststand);

  if(self hasweapon(w_laststand)) {
    self.var_3c26ce251ed564ca = 1;
  }

  foreach(weaponobject in weaponlist) {
    weaponname = weaponobject.basename;

    if(weaponclass(weaponobject) == "pistol") {
      s_pistol = spawnStruct();
      s_pistol.weaponname = weaponname;
      s_pistol.weaponobject = weaponobject;
      var_e5ca507329f88439 = function_6d6af8144a5131f1(var_e5ca507329f88439, s_pistol);
    }
  }

  if(var_e5ca507329f88439.size == 1) {
    return var_e5ca507329f88439[0].weaponobject;
  } else if(!var_e5ca507329f88439.size) {
    return w_laststand;
  }

  var_df7bebe47df2d8e0 = var_e5ca507329f88439[0].weaponname;
  var_37186097517b5223 = 0;

  if(isarray(level.weaponmetadata)) {
    foreach(s_weapon in level.weaponmetadata) {
      if(isDefined(s_weapon.laststandpriority) && s_weapon.laststandpriority > var_37186097517b5223 && isDefined(s_weapon.weapon)) {
        foreach(s_pistol in var_e5ca507329f88439) {
          if(s_pistol.weaponname == s_weapon.weapon) {
            var_37186097517b5223 = s_weapon.laststandpriority;
            var_df7bebe47df2d8e0 = s_weapon.weapon;
            break;
          }
        }
      }
    }
  }

  foreach(s_pistol in var_e5ca507329f88439) {
    if(s_pistol.weaponname == var_df7bebe47df2d8e0) {
      return s_pistol.weaponobject;
    }
  }
}

function function_d564d036834cc766() {
  self.health = level.laststandrevivehealth;
  thread ob_laststand_alive_check(0);
}

function function_59bb85cf2b5af12f(params) {
  if(isDefined(params.progress) && istrue(level.var_520545ce455767b6)) {
    if(!self getbeingrevived()) {
      self.health = int(level.laststandrevivehealth * params.progress);

      if(isDefined(self.laststandreviveent) && isDefined(self.laststandreviveent.objidnum)) {
        scripts\mp\objidpoolmanager::objective_set_progress(self.laststandreviveent.objidnum, params.progress);
      }
    }
  }
}

function function_144b0ea22640fc8e(revived) {
  thread ob_laststand_alive_check(revived);
}

function private ob_laststand_alive_check(revived) {
  if(!isPlayer(self)) {
    return;
  }

  self notify("endon_ob_laststand_alive_check");
  self endon("endon_ob_laststand_alive_check");
  self endon("disconnect");

  if(issharedfuncdefined(#"ob_pvpve", #"hash_f383e3bc7a6b4400")) {
    if(!istrue(callsharedfunc(#"ob_pvpve", #"hash_f383e3bc7a6b4400"))) {
      return;
    }
  }

  var_eb5a9091076e21e8 = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(istrue(revived)) {
    self.var_64a7c6d08000be36 = undefined;
    self.var_b43e8623c0dd6a67 = undefined;
    return;
  }

  self.var_443a9d08da23b7dd = gettime();
  waitframe();
  var_95d11513b9b53a0d = 1;
  var_eb5a9091076e21e8 = array_removeundefined(var_eb5a9091076e21e8);

  foreach(player in var_eb5a9091076e21e8) {
    if(isalive(player) && player.sessionstate == "playing") {
      var_95d11513b9b53a0d = 0;
      break;
    }

    if(isDefined(level.var_fd15b9ad0f909a26)) {
      if(!player[[level.var_fd15b9ad0f909a26]]()) {
        var_95d11513b9b53a0d = 0;
        break;
      }
    }
  }

  if(var_95d11513b9b53a0d) {
    foreach(player in var_eb5a9091076e21e8) {
      player.squadwiped = 1;
    }
  }

  var_192c781ad2c7d253 = 0;

  foreach(player in level.players) {
    if(function_f3645fa4bfb45a97(player)) {
      var_192c781ad2c7d253 = 1;
      break;
    }
  }

  if(isDefined(self.team) && isDefined(self.sessionsquadid)) {
    squad_leader = squad_utility::getsquadleader(self.team, self.sessionsquadid);
  }

  lastplayeralive = squad_leader;

  if(var_95d11513b9b53a0d) {
    var_3af19e982dfa3220 = -1;

    foreach(player in var_eb5a9091076e21e8) {
      if(isDefined(player.var_443a9d08da23b7dd) && player.var_443a9d08da23b7dd > var_3af19e982dfa3220) {
        lastplayeralive = player;
        var_3af19e982dfa3220 = player.var_443a9d08da23b7dd;
      }
    }
  }

  if(var_95d11513b9b53a0d && !istrue(level.gameended) && is_equal(self, lastplayeralive)) {
    thread scripts\mp\gametypes\ob::onsquadeliminated(var_eb5a9091076e21e8, var_192c781ad2c7d253);
  }
}

function function_f3645fa4bfb45a97(player) {
  if(!scripts\mp\utility\player::isinlaststand(player) && isalive(player) && player.sessionstate == "playing") {
    return true;
  }

  if(isalive(player) && player scripts\cp_mp\laststand::function_546201bb34cf36ce() > 0) {
    return true;
  }

  if(isalive(player) && isalive(player.var_c5668dcaf32afbc3)) {
    return true;
  }

  if(isalive(player) && istrue(player.var_ac45ef94bf07d7d0)) {
    return true;
  }

  return false;
}

function function_493ca4f5db3e7909(purchaseindex) {
  itemindex = purchaseindex;
  assert(isDefined(level.var_989093b9a969783.items[itemindex]));
  itemdata = level.var_989093b9a969783.items[itemindex];
  cost = scripts\cp_mp\loot\common_kiosk::_getactualcost(self, itemdata);
  cost *= 100;
  var_70961c170a38d303 = undefined;
  squad = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(squadmate in squad) {
    if(!isDefined(squadmate) || squadmate == self) {
      continue;
    }

    if(!isalive(squadmate) && !istrue(squadmate.var_c059cd563d289723)) {
      var_70961c170a38d303 = squadmate;
      break;
    }
  }

  if(isDefined(var_70961c170a38d303)) {
    var_70961c170a38d303.var_b6c4b0b7ace6006e = 1;
    var_4675a1acfe76662 = self.origin + anglesToForward(self.angles) * 300;
    var_70961c170a38d303 thread function_ef6adc9492d03ef(var_4675a1acfe76662);
  }
}

function private function_8868d59e008df32d() {
  return (level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5;
}

function function_ef6adc9492d03ef(v_start) {
  level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(v_start, "revive");
  spawnheight = getdvarfloat(@ "hash_50f18343f33b6153", 8000);
  spawnorigin = v_start;
  spawnorigin += (0, 0, spawnheight);
  self.var_c059cd563d289723 = 1;
  var_ad4dd16f29e24b77 = 0;
  var_dfab0807d83a77fe = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(var_ad4dd16f29e24b77, var_dfab0807d83a77fe);

  if(var_ad4dd16f29e24b77 > 0) {
    self waittill("fadeDown_complete");
  }

  facingorigin = self[[level.var_8868d59e008df32d]]();
  toselection = facingorigin - spawnorigin;
  spawnangles = vectortoangles(vectorNormalize(toselection));
  self.var_c059cd563d289723 = undefined;

  if(!isalive(self) || self.sessionstate == "spectator") {
    self notify("force_spawn");
    waitframe();

    if(!isalive(self) || self.sessionstate == "spectator") {
      self.var_6c0f9f7e906a5ee6 = 1;
      scripts\mp\playerlogic::spawnclient();
    }
  }

  if(issharedfuncdefined(#"ob_pvpve", #"hash_c69889de57e82c49")) {
    callsharedfunc(#"ob_pvpve", #"hash_c69889de57e82c49");
  }

  self setOrigin(spawnorigin);
  self setplayerangles(spawnangles);

  if(level.parachutecancutautodeploy) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  if(level.parachutecancutparachute) {
    self skydive_cutparachuteon();
  } else {
    self skydive_cutparachuteoff();
  }

  thread scripts\cp_mp\parachute::startfreefall(level.parachutedeploydelay, 0, undefined, undefined, 1);

  if(isDefined(self.primaryweapons)) {
    foreach(weapon in self.primaryweapons) {
      self givemaxammo(weapon);
      self setweaponammoclip(weapon, weaponclipsize(weapon));
    }
  }
}
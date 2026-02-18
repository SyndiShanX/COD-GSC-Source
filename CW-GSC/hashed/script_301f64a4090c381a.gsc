/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_301f64a4090c381a.gsc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_e38c57c1;

function private autoexec __init__system__() {
  system::register(#"hash_7576c66086ab62aa", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(getdvarint(#"hash_4894e3a42dd84dfa", 0)) {
    callback::on_connect(&on_player_connect);
  }
}

function private postinit() {
  if(getdvarint(#"hash_4894e3a42dd84dfa", 0)) {
    level thread devgui();
  }
}

function function_9af806be(var_c5b25bc5) {
  if(isDefined(self.var_2fe40b9d)) {
    self function_2a94cd59();
  }

  self.var_2fe40b9d = var_c5b25bc5;

  switch (var_c5b25bc5) {
    case 1:
      self player::function_2a67df65(#"fl1", -50);
      self zm_utility::set_max_health();
      break;
    case 2:
      self perks::perk_setperk(#"hash_53010725c65a98a5");
      break;
    case 3:
      self player::function_2a67df65(#"db1", 50);
      self zm_utility::set_max_health();
      break;
    case 4:
      self perks::perk_setperk(#"hash_130074ec6de7a431");
      break;
    case 5:
      self perks::perk_setperk(#"specialty_faction_helmet");
      break;
    case 6:
      self zm_laststand::function_3a00302e(1);

      if(!isDefined(self.n_regen_delay)) {
        self.n_regen_delay = zombie_utility::get_zombie_var("player_health_regen_delay");
      }

      self.n_regen_delay += 1;
      break;
  }
}

function function_2a94cd59() {
  var_c5b25bc5 = self.var_2fe40b9d;

  self.var_2fe40b9d = undefined;

  switch (var_c5b25bc5) {
    case 1:
      self player::function_b933de24(#"fl1");
      break;
    case 2:
      self perks::perk_unsetperk(#"hash_53010725c65a98a5");
      break;
    case 3:
      self player::function_b933de24(#"db1");
      break;
    case 4:
      self perks::perk_unsetperk(#"hash_130074ec6de7a431");
      break;
    case 5:
      self perks::perk_unsetperk(#"specialty_faction_helmet");
      break;
    case 6:
      self zm_laststand::function_409dc98e(1, 0);
      self.n_regen_delay -= 1;
      break;
  }
}

function function_6a7a1533(var_c5b25bc5) {
  return self.var_2fe40b9d === var_c5b25bc5;
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isPlayer(shitloc) || !isDefined(shitloc.var_2fe40b9d)) {
    return psoffsettime;
  }

  switch (shitloc.var_2fe40b9d) {
    case 1:
      if(shitloc zm_weapons::function_f5a0899d(surfacetype, 0)) {
        psoffsettime *= 1.15;
      }

      break;
    case 3:
      if(shitloc zm_weapons::function_f5a0899d(surfacetype, 0)) {
        psoffsettime *= 0.85;
      }

      break;
    case 6:
      if(boneindex == "MOD_MELEE" && isDefined(surfacetype) && !surfacetype.isriotshield && !zm_loadout::is_hero_weapon(surfacetype)) {
        psoffsettime += 200;
      }

      break;
  }

  return int(psoffsettime);
}

function function_183814d3() {
  self thread function_68992377(1, 1000);
}

function function_c3f3716() {
  self thread function_68992377(3, 500);
}

function function_863dc0ef(n_cost) {
  if(self function_6a7a1533(-1000)) {
    n_cost += -1000;
    return int(max(n_cost, 0));
  }

  return n_cost;
}

function function_cbf286b0() {
  if(!isDefined(self.var_2fe40b9d)) {
    return 0;
  }

  switch (self.var_2fe40b9d) {
    case 2:
      return 0.25;
    case 4:
      return -0.25;
  }

  return 0;
}

function function_3da195ec(weapon) {
  if(!self function_6a7a1533(5)) {
    return false;
  }

  if(aat::is_exempt_weapon(weapon)) {
    return false;
  }

  return true;
}

function private function_68992377(var_c5b25bc5, var_97f3fbb7) {
  self endon(#"disconnect");

  if(self function_6a7a1533(var_c5b25bc5)) {
    wait 1;
    self zm_score::add_to_player_score(var_97f3fbb7);
  }
}

function devgui() {
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x9e>");
  adddebugcommand("<dev string:x103>");
  adddebugcommand("<dev string:x165>");
  adddebugcommand("<dev string:x1c9>");
  adddebugcommand("<dev string:x22f>");
  adddebugcommand("<dev string:x293>");
  level.var_8e9d88b6 = [];
  level.var_8e9d88b6[# "fl1"] = 1;
  level.var_8e9d88b6[# "tn1"] = 2;
  level.var_8e9d88b6[# "db1"] = 3;
  level.var_8e9d88b6[# "bf1"] = 4;
  level.var_8e9d88b6[# "helmets1"] = 5;
  level.var_8e9d88b6[# "season1"] = 6;

  while(true) {
    waitframe(1);
    str_command = getdvarstring(#"hash_443a451d4b2f9de2", "<dev string:x2e7>");

    switch (str_command) {
      case # "bf1":
      case # "fl1":
      case # "season1":
      case # "helmets1":
      case # "tn1":
      case # "db1":
        foreach(e_player in getplayers()) {
          e_player function_9af806be(level.var_8e9d88b6[str_command]);
        }

        break;
      case # "clear":
        foreach(e_player in getplayers()) {
          e_player function_2a94cd59();
        }

        break;
      case # "player_4_tn1":
      case # "hash_114b0d4db1699d85":
      case # "hash_138c6bb93906947e":
      case # "hash_15ba4b3713a7633c":
      case # "hash_34fa2d4dc5eb050f":
      case # "hash_361dd9611538c0df":
      case # "player_2_tn1":
      case # "hash_410061a21976fb0d":
      case # "hash_41af396a9a424584":
      case # "hash_41e44f4b44ea8a50":
      case # "hash_42e797318220640c":
      case # "player_1_tn1":
      case # "hash_478329f218767aab":
      case # "hash_481abb611f991c37":
      case # "player_3_tn1":
      case # "hash_4ebf4bdbdeca4671":
      case # "hash_53c07f6aa4b3f3d2":
      case # "hash_544ef1318c01b458":
      case # "hash_546d41eb20e9ed47":
      case # "hash_5642f90448974736":
      case # "hash_5a4711612a21ad6d":
      case # "hash_6601596aaf4e0e5e":
      case # "hash_66603731967362a6":
      case # "hash_7f4e4b4da709788d":
        n_player = int(strtok(str_command, "<dev string:x2eb>")[1]);
        var_afaaaae2 = strtok(str_command, "<dev string:x2eb>")[2];
        function_c1ccd7f3(&function_9af806be, n_player, level.var_8e9d88b6[var_afaaaae2]);
        break;
      case # "hash_39098b3e5f02ee30":
      case # "hash_3b6473dd2b0c56c7":
      case # "hash_10e7f44f002ed3c6":
      case # "hash_33d0946a156bc141":
        n_player = int(strtok(str_command, "<dev string:x2eb>")[1]);
        function_c1ccd7f3(&function_2a94cd59, n_player);
        break;
      default:
        break;
    }

    setDvar(#"hash_443a451d4b2f9de2", "<dev string:x2e7>");
  }
}

function on_player_connect() {
  self endon(#"disconnect");
  level flag::wait_till("<dev string:x2f0>");
  self devgui_player_menu();
}

function function_c1ccd7f3(var_fc09f1a3, n_player, ...) {
  a_e_players = getplayers();

  if(a_e_players.size >= n_player) {
    util::single_func_argarray(a_e_players[n_player - 1], var_fc09f1a3, vararg);
  }
}

function devgui_player_menu() {
  self function_1c3ffffd();
  var_21c1ba1 = self getentitynumber() + 1;
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x334>" + var_21c1ba1 + "<dev string:x37f>");
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x38a>" + var_21c1ba1 + "<dev string:x3d4>");
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x3df>" + var_21c1ba1 + "<dev string:x426>");
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x431>" + var_21c1ba1 + "<dev string:x47b>");
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x486>" + var_21c1ba1 + "<dev string:x4cc>");
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x4dc>" + var_21c1ba1 + "<dev string:x521>");
  adddebugcommand("<dev string:x30c>" + self.name + "<dev string:x32d>" + var_21c1ba1 + "<dev string:x530>" + var_21c1ba1 + "<dev string:x563>");
}

function function_1c3ffffd() {
  adddebugcommand("<dev string:x570>" + self.name + "<dev string:x594>");
}
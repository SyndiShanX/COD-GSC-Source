/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_5bee8bce116c05a.gsc
****************************************************/

#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\game\sp\equipment_wheel;
#using scripts\sp\loot;
#using scripts\sp\player;
#using scripts\sp\player\health_management;
#using scripts\sp\player\perk_manager;
#namespace namespace_9ad77be98906f282;

function private autoexec __init__system__() {
  system::register(#"hash_cb1a92f6c028cc27", #"perk_manager", &pre_main, undefined);
}

function private pre_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  player = level.player;
  player perk_manager::function_dba42d77c0bae3cd("UENh\xe7\xd3qq\x90\xf5\x93h1\x17\xb0\x02\a>E\x97", &function_fe246debca453b97, &clear_magazine, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xa0\xfa\x1a\a\x97\xf0v\x1e\b\x80\xa5\x95KP\xba\x99\x8f\xb1\xde\x0e", &function_db2235f99c75c5ea, &clear_magazine, undefined);
  player perk_manager::function_dba42d77c0bae3cd("&\xb1\x96?\xb3\xca\xb2u\x92\xf1$\xf5iO\xf5\xa3$n", &function_1bf52b4994264a27, &function_68a81ba53ff0109c, undefined);
  player perk_manager::function_dba42d77c0bae3cd("v0\xde\xcf\x98\x01?\xc5\xa4\xc3\xa1\\\xebC\xb0\x84\x85\x1f", &function_acde4ff3edb1c53a, &function_68a81ba53ff0109c, undefined);
  player perk_manager::function_dba42d77c0bae3cd("9D\xb7\x19\x9e\xbc+X\x86\xe8\xac\xcfF\xfd \xae\xa14", &function_666b8fd48144d2b0, &function_dc2225e06136c07b, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x13\x18A\x1c\x88\xb2\x0fl\xd8\x1e*\x81\xe9\xf9\xdd\xc7_\xd3", &function_2f4fbff647c814a9, &function_dc2225e06136c07b, undefined);
  player perk_manager::function_dba42d77c0bae3cd("nhM\xae\xd4J\x16\xa1\xf2#1\xde\xacE\x9a", &function_caf9901d42a3a5bf, &function_cb01020c47e1922e, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xf1z\xda\x91Z\x1e\xe1\xe7q\xc66V.}\\", &function_e90ccec898f7e72, &function_cb01020c47e1922e, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xdb\xf7{\xc4\x18\xd3\xde\xbd40\x02\xcd\x05\x87\xd5f\xec\xb5\xf6K\x18M", &function_a5bd273d04429f4, &clear_hipfire, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xcd\aY\x1b\xb4a\xd8\xe8y\xfa\xee\x0e}\xa1\xd2\x0e\x99i9\xac\xd7#", &function_fdc9903382b54d5d, &clear_hipfire, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xa1\xc8\xd4\xb8\xa0F\x19)\xa8\x1dM\xc6u\x93ij1\x91t[9", &function_44690566eef9bc8f, &clear_steady, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xe8)Q\x16w\x86\xd3(PvZ\xd6\x1fb\x91\xa8<'6\xd1\xe7", &function_f7d40e4e4ef52a82, &clear_steady, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xf7\xd3B\xa6PA=\xa3\x1a\xe9?\xd0\xf0k\xefUS{\x9b\x7f@\x9d\xd9\x03", &function_c62c239223fca399, &clear_penetrate, undefined);
  player perk_manager::function_dba42d77c0bae3cd("u`1r{\xbe*\xe1\xb1&\xcbp\x8eq \xac\x1cd\xf1qh\x8f'\x04", &function_fe86f591a63a8820, &clear_penetrate, undefined);
  player perk_manager::function_dba42d77c0bae3cd("g\xf1\x82C\xbd\x03#\xe6E\x05\xde\x9f\xb1)\x89\x87\xfdi\xb6\xac\xf2Z|", &function_dabb12a8651ac997, &clear_marksman, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x18\xd9\x12%HH8\f@\x94w$\x03\xb5\xc40\x12fB'\x16EK\x15", &function_4e74f8ad2b230fe9, &clear_scavenger, undefined);
  player perk_manager::function_dba42d77c0bae3cd("'\xac\x01\xd7\xdb\xab\xbe\x1az\xa5\x11I\xa6p\x1e\x98\x88&\x19\xa4\xeb", &function_7491d643f1fe631e, &clear_gunner, undefined);
  player perk_manager::function_dba42d77c0bae3cd("#\xd0\xe7w\xa8Yfwda\x893q\xee\x93oA", &function_c543080ae8b2a642, &function_b9999eaf24c41513, undefined);
  player perk_manager::function_dba42d77c0bae3cd("s\x1c\x95\xb1\xd2\xb0l\x1dy\xbe\xc2'\xb5\xb7\xc9\xaf#", &function_637148cf0ac8fb4f, &function_b9999eaf24c41513, undefined);
  player perk_manager::function_dba42d77c0bae3cd("-\xado\xaa\xcc\x9dH\xf5\xf4!T\xd1\xa3p\x98\x02\x83\xb4T\x91A\a/\xf2V\x11Q", &function_fa1a68925036d08c, &function_4aeece13a08563d5, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x9b\x96\x01`\x19\xccI\x98\x05E\xb3{'\x9e\xbeXR\xdaT\x1d\x85\xa5\xc6M\x90w", &function_e284df1eee40b3e3, &function_f19763b4692cacf0, undefined);
  player perk_manager::function_dba42d77c0bae3cd("y\x16\x93\x0f\x8f\xa8\xc2\xf6Ug\x88\x88O\xa7\x1b\xfc;\x19\x19g\xb1\xf8\xd9\x91B", &function_91f5b41b456ad496, &function_bf3688ec0a59b47b, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xa2V\xb4\x05\x89#A\xd2\x02+\x1b\xf4\xb5z\xf1\xfd\xd4\x95\xe5x\xa0\x80\x99x", &function_b1f85a81ff5efff2, &function_f684c5e41eff3a05, undefined);
  player perk_manager::function_dba42d77c0bae3cd("R?Qj\xa5O\xf0D\xb1rO\xea)\x90Q\xe4\xfb\x9b \xd7u\x8bI\n", &function_6e611db2b873273f, &function_f684c5e41eff3a05, undefined);
  player perk_manager::function_dba42d77c0bae3cd("uT\xedrD_\x85,[\xf1E\xfe\xdc\x15J\xc5xs\x9b\xeeMW\xd3", &function_33bbb1d2b354e3d1, &function_8e3a52414a046aaa, undefined);
  player perk_manager::function_dba42d77c0bae3cd("GV\xb5\x9e\x7f\xcf\x98\xfe\xd81\x15\xed\x16x9E*\x14\xd7\xffU\x9d\x90", &function_7186a91acee56a0f, &function_2aa70ac0fb3d07b8, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x1b\xc4T\xdf,\x11\xb7\x06\x84yib\xf1\xbc\xe4\x96\x18\xfb\xc91p\x8fR", &function_24f1b2022ee0d802, &function_39cd691f8b5de351, undefined);
  player perk_manager::function_dba42d77c0bae3cd("K\x0fQ\xa6\x9b\xe9+w{f\x19>'[\x80WS\xcc\x02", &function_514058b39a238721, &function_5fdb0c7c5ce4eace, undefined);
  player perk_manager::function_dba42d77c0bae3cd("J`\x05\xde\x95h}\v\x18\x05\xa3\x1d\x1a \xfdF\\6\t\x9ei\xd2Z", &function_80d385519037b0a3, &function_71acb37ba3167014, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x9b[\xfd\xf9C\x9a\x9dE\xcb\xb92\xbb\xa61\xe7h\b\xaf\x96\xf09A\x12", &function_de2c22eadfbed2a6, &function_2b289f64e5a7bd7d, undefined);
  player perk_manager::function_dba42d77c0bae3cd("/\x13\xfe\x03\x91\xbaGP0\xf0t\x8f`9\xd4x\xf7\xe7\xf5\xc4\xaf$\x9c\x11\xd3\xfc", &function_7257c5bc392aa6a0, &clear_assassin, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xd3\xbc\xa9.\xec]\xbd\xfe\x9d\x84\xd6\xa3\xed\xfc\n\x8b\xa3\xf4\xaf\x15\xa4\xa3", &function_571c7b92f3581d72, &function_5703024005a59d21, undefined);
  player perk_manager::function_dba42d77c0bae3cd("kUtz\xf2\x85]\x06\x15\xb4d:>!\xb0\xd0Y\xeb\x90s \x9c", &function_13853ec3ac6c44bf, &function_5703024005a59d21, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xf6S\xf6v`\xd7\xd3\xbe\xd9cW\x84\xba\xcd\xafN_\x9eH\xbb\tv(\xd0\xed\xca\xa0g\xfd\xf7$", &function_bdf11f1724511452, &function_1f38a4c570c97b3d, undefined);
  player perk_manager::function_dba42d77c0bae3cd("e\xf9+(\xf0p\xd0\xedLg\xbf\xdc-\x1f\x80\xff+\xcd", &function_65240182df0dc0dc, &function_1ef2d376e2f497a1, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\t\xe4\xae\xb5\xc9W\xeb\xf4}\xd8k,\xbe\xbf:\x99\xe7\xa9\x9bs;HP", &set_lightweight, &clear_lightweight, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x9e\x1b\x8e\x1f\x0e\x8f\xc69\xcd\x83\x976\xaa\xefv\x83\xbc\xeb", &set_greedy, &clear_greedy, undefined);
  player perk_manager::function_dba42d77c0bae3cd("`M\x8dh\x8c\x97#\x90\xbf\xe7\x9c\xd2\x8e\xf4\bY|\xb8\x1a\x9dG\xd0^&\xfc", &function_729dd0012a59b1b5, &function_fdddb3d709246b4, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xdcp+l\xd2\xb0\x8d:^\xf5\x836\xaf1\xc6\xf6\xdb\xc8\xb1]\xe6\xa3\xaf1", &function_daf9e217eb108a6d, &function_f630b693e6649610, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xd4[{\":\xb3\xcbG\r\xb8\xf4\x81\x0e\xe2\xe1V\x80\xd4\xf7K)\x8c\x94\xc3V\xdc\xb9\x9d", &function_5a1a3cd9ce961708, &function_aec7fef0126408cf, undefined);
  player perk_manager::function_dba42d77c0bae3cd("7\x1c\xca\x8d\x96\v\x8d\x8e/}V\x1e8\xb1\xbdnZ;\xb2\xaf\xdc\xd0ZV\x8d\x8c\xf52", &function_b148a7905de5b21, &function_aec7fef0126408cf, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\x9b_\xee\x99c\x86h\xe9/>\xb4\xcf\x81\xa70\b\x8fx", &function_6628d93c0be38cdf, &function_b1b9369b357a2c0c, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xdc8\xac\xd8K\x856\xa3y\xbe3\xb1\x96\x9bl\r\xf5\x91", &function_ce12e72597c87f12, &function_b1b9369b357a2c0c, undefined);
  player perk_manager::function_dba42d77c0bae3cd("\xd0\xdeq\xef!\"\xa8\x93x>\x81U\xd5\xf9\xe1}tn[\xb8\x8f\x03p\xbe#", &function_3ba4a0be4b05641, &function_cd20a6f80d36c138, undefined);
  player perk_manager::function_dba42d77c0bae3cd("Kl:\xb3ue\xacB6A\xaft\x04)v$\x85\x91\xce\x02\x94A\xf1B!", &function_b9c3777dd6090b28, &function_cd20a6f80d36c138, undefined);
}

function private function_729dd0012a59b1b5() {
  assert(isPlayer(self));
  thread laststand_thread();
}

function private function_fdddb3d709246b4() {
  assert(isPlayer(self));
  self notify("\x0f\xed\xa4\n\x13\x01\x1an`\x93\aRm\xd4m\a");
}

function private laststand_thread() {
  self notify("L0\x99f`\x98f\xb0MF\v\x99\x9c\xb0V\x83");
  self endon("L0\x99f`\x98f\xb0MF\v\x99\x9c\xb0V\x83");
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("\x0f\xed\xa4\n\x13\x01\x1an`\x93\aRm\xd4m\a");
  var_3b48d68fcaf0f091 = 1;
  var_ef31f18a10bb5a25 = 0.2;

  while(true) {
    player waittill("J\a\xa7L\xabmA\xc9~\nr", deathshieldtime);

    if(isDefined(player.var_bfd773c638ca7659)) {
      continue;
    }

    player notify("\x04\x1c\xe2\xf4\xfd\x81Ec\x95");
    speedbuffduration = getdvarint(@ "hash_87db853764e7f565", 3000);
    var_adacb2310406476a = getdvarfloat(@ "hash_240d7605dc136330", 0.15);
    var_25913477cebae24e = var_ef31f18a10bb5a25;
    player thread function_bccb70c4e13c855f(var_25913477cebae24e, var_3b48d68fcaf0f091);
    player val::set("\x04\x1c\xe2\xf4\xfd\x81Ec\x95", "\x8f}T\xa3\xdc>\x9a<\\'\xe04$\x9eG{\xf2\x81\xf59S", 1 + var_adacb2310406476a);
    player utility::delaythreadendon(speedbuffduration / 1000, "\x04\x1c\xe2\xf4\xfd\x81Ec\x95", &val::reset_all, "\x04\x1c\xe2\xf4\xfd\x81Ec\x95");
    player powerups::powerup_activate("\x85\x1a\xd3\x853\"\x06&`B\x97\xfe\x84_\xac|\xe2");
  }
}

function private function_bccb70c4e13c855f(var_25913477cebae24e, gaintime) {
  self notify("T\xda>\x81\x98Bi\x02\x9e\x95\x1b\x03H\x81%");
  self endon("T\xda>\x81\x98Bi\x02\x9e\x95\x1b\x03H\x81%");
  player = self;
  assert(gaintime > 0);
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  steppct = var_25913477cebae24e / gaintime / level.framedurationseconds;
  endtime = gettime() + gaintime * 1000;

  while(gettime() <= endtime) {
    newhealth = min(1, player getnormalhealth() + steppct);
    player player_sp::set_normalhealth(newhealth);
    waitframe();
  }
}

function private function_daf9e217eb108a6d() {
  assert(isPlayer(self));
  enemies = getaiarray("?\xb1\xc0\x9a");

  foreach(guy in enemies) {
    guy utility_sp::add_damage_function(&function_28ae8e193ffe36a4);
  }

  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_75bf2d0b8697b3ab);
}

function private function_f630b693e6649610() {
  assert(isPlayer(self));
  enemies = getaiarray("?\xb1\xc0\x9a");

  foreach(guy in enemies) {
    guy utility_sp::remove_damage_function(&function_28ae8e193ffe36a4);
  }

  utility_sp::remove_global_spawn_function("?\xb1\xc0\x9a", &function_75bf2d0b8697b3ab);
}

function private function_75bf2d0b8697b3ab() {
  utility_sp::add_damage_function(&function_28ae8e193ffe36a4);
}

function private function_56a01e1bd48e0e07() {
  assert(isPlayer(self));
  health_management::function_1f9f4d9374facd2(self.basehealthscale ?? 1, 0);
}

function private function_28ae8e193ffe36a4(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  if(!isalive(self)) {
    player = level.player;

    if(isDefined(player.var_bfd773c638ca7659)) {
      return;
    }

    if(!isDefined(attacker) || attacker != player) {
      return;
    }

    now = gettime();
    entnum = self getentitynumber();

    if(now - (player.bloodlustfirst ?? 0) > 2000) {
      player.bloodlustfirst = now;
      player.bloodlustkills = undefined;
    }

    if(!isDefined(player.bloodlustkills)) {
      player.bloodlustkills = [];
    }

    player.bloodlustkills[entnum] = now;

    if(player.bloodlustkills.size >= 3) {
      player notify("\x91|\xfc\xba?\xe7o|d");
      player health_management::function_1f9f4d9374facd2((player.basehealthscale ?? 1) * 1.2, 0);
      player utility::delaythreadendon(10, "\x91|\xfc\xba?\xe7o|d", &function_56a01e1bd48e0e07);
      player powerups::powerup_activate("@\xc7[:\xf1\xbd!\xd5\x02<*#\xf3\xd8*s\xf6");

      if(isalive(player)) {
        newhealth = min(1, player getnormalhealth() + 0.2);
        player player_sp::set_normalhealth(newhealth);
      }

      player.bloodlustfirst = undefined;
      player.bloodlustkills = undefined;
    }
  }
}

function private function_bdf11f1724511452() {
  assert(isPlayer(self));
  player_sp::function_db2292ac8b0798a0(0.5);
}

function private function_1f38a4c570c97b3d() {
  assert(isPlayer(self));
  player_sp::function_db2292ac8b0798a0(1);
}

function private function_65240182df0dc0dc() {
  assert(isPlayer(self));
  self setperk("\x0ew\x82\xe6\x9c2\x11J\r\xd7\xa1]\xbb\xe5 [", 1);
}

function private function_1ef2d376e2f497a1() {
  assert(isPlayer(self));
  self unsetperk("\x0ew\x82\xe6\x9c2\x11J\r\xd7\xa1]\xbb\xe5 [", 1);
}

function private set_lightweight() {
  assert(isPlayer(self));
  thread lightweightwatchthread();
}

function private clear_lightweight() {
  assert(isPlayer(self));
  self notify("\xc6\xd2\x9d4:wV-\xd9\r\xa3\xea\x85G\xc6\x1a\xa8\rN\xcaa2");
  val::reset_all("\x88\xf4\xb9\x84\xbd9+v\x97\xc1\x9f");
}

function private lightweightwatchthread() {
  self notify("8\x19\xee\x8a4\xa9\xa3\xb3Dh\xd1e\xa3l\x01\xe2");
  self endon("8\x19\xee\x8a4\xa9\xa3\xb3Dh\xd1e\xa3l\x01\xe2");
  assert(isPlayer(self));
  self endon("\xc6\xd2\x9d4:wV-\xd9\r\xa3\xea\x85G\xc6\x1a\xa8\rN\xcaa2");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  speedbuffduration = getdvarint(@ "hash_87db853764e7f565", 3000);
  var_adacb2310406476a = getdvarfloat(@ "hash_240d7605dc136330", 0.25);

  while(true) {
    if(!isDefined(self.var_bfd773c638ca7659) && isDefined(self.var_5732b2d6948b3e42) && self.var_5732b2d6948b3e42 + speedbuffduration >= gettime()) {
      self notify("\x1b\xd2v\r:\xeeei\xd9\x1at\xafst,9t");
      val::set("\x88\xf4\xb9\x84\xbd9+v\x97\xc1\x9f", "\x8f}T\xa3\xdc>\x9a<\\'\xe04$\x9eG{\xf2\x81\xf59S", 1 + var_adacb2310406476a);
      powerups::powerup_activate("\x0e\xed\xbb\xca\x9c\xae\xe0\xf5li\x9d\rtw+\xb4\x9d\r:");
    } else {
      val::reset_all("\x88\xf4\xb9\x84\xbd9+v\x97\xc1\x9f");
    }

    waitframe();
  }
}

function private set_greedy() {
  assert(isPlayer(self));
  self.var_7098e45b194d6315 = 1.25;
}

function private clear_greedy() {
  assert(isPlayer(self));
  self.var_7098e45b194d6315 = undefined;
}

function private function_7186a91acee56a0f() {
  assert(isPlayer(self));
  loot::lootsetautopickup("'X\x99\x94\xd9\xcc^\x9d\xb7\x15", 1);
}

function private function_2aa70ac0fb3d07b8() {
  assert(isPlayer(self));
  loot::lootsetautopickup("'X\x99\x94\xd9\xcc^\x9d\xb7\x15", 0);
}

function private function_24f1b2022ee0d802() {
  assert(isPlayer(self));
  loot::lootsetautopickup("'X\x99\x94\xd9\xcc^\x9d\xb7\x15", 1);
  thread magnetic_2_thread();
}

function private function_39cd691f8b5de351() {
  assert(isPlayer(self));
  loot::lootsetautopickup("'X\x99\x94\xd9\xcc^\x9d\xb7\x15", 0);
  self notify("m\xc2;7\x95\x1d\xd2l\xaf\xc8\xaf\xa3\xd0\x93V\x16\x91");
}

function private magnetic_2_thread() {
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self notify("m\xc2;7\x95\x1d\xd2l\xaf\xc8\xaf\xa3\xd0\x93V\x16\x91");
  self endon("m\xc2;7\x95\x1d\xd2l\xaf\xc8\xaf\xa3\xd0\x93V\x16\x91");

  while(true) {
    self waittillmatch("L\xf3NF\x8a{\xcf\xa3^", "'X\x99\x94\xd9\xcc^\x9d\xb7\x15");

    if(!istrue(utility::playerarmorenabled())) {
      continue;
    }

    if(player_sp::playercanusearmorplate()) {
      player_sp::function_ae8d8e5fe2075d2a();
    }
  }
}

function private function_514058b39a238721() {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_4033a044f9dcb251", 1);
}

function private function_5fdb0c7c5ce4eace() {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_4033a044f9dcb251", 0);
}

function private function_80d385519037b0a3() {
  assert(isPlayer(self));
  self.armor.useoffhand = 1;
}

function private function_71acb37ba3167014() {
  assert(isPlayer(self));
  self.armor.useoffhand = undefined;
}

function private function_de2c22eadfbed2a6() {
  assert(isPlayer(self));
  self.armor.useoffhand = 1;
  thread quickfix_2_thread();
}

function private function_2b289f64e5a7bd7d() {
  assert(isPlayer(self));
  self.armor.useoffhand = undefined;
  self notify("\xd0\xd2(\xaf\x0f~\x0f5}z\x1f{\x134\xd3\xd8\x91");
}

function private quickfix_2_thread() {
  self notify("6\x192p\x14Y\xb1no\xe1\xd7\r\xf4<Y`");
  self endon("6\x192p\x14Y\xb1no\xe1\xd7\r\xf4<Y`");
  self endon("\xd0\xd2(\xaf\x0f~\x0f5}z\x1f{\x134\xd3\xd8\x91");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    utility::waittill_any("\x85'[{9_\xe0\xd8a\xa3\xac\xeb\xa5\xb9\xe6\xac\x9ct\xb2\x8c", "\xccAq\x85\x82\xc0\x7f\xediWu\x9b");
    self notify("\x92j\xef\xf1\x85>\x98m\xde^\xd8\xa2A\xbcZt\xe4Oz\xde\xefn");
  }
}

function private function_571c7b92f3581d72() {
  assert(isPlayer(self));
  self.basehealthscale = 1.2;
  health_management::function_1f9f4d9374facd2(1.2);
}

function private function_13853ec3ac6c44bf() {
  assert(isPlayer(self));
  self.basehealthscale = 1.4;
  health_management::function_1f9f4d9374facd2(1.4);
}

function private function_5703024005a59d21() {
  assert(isPlayer(self));
  self.basehealthscale = 1;
  health_management::function_1f9f4d9374facd2(1);
}

function private function_33bbb1d2b354e3d1() {
  assert(isPlayer(self));
  self.armor.platearmoramount = 50;
}

function private function_8e3a52414a046aaa() {
  assert(isPlayer(self));
  self.armor.platearmoramount = undefined;
}

function private function_c543080ae8b2a642() {
  assert(isPlayer(self));

  if(!isDefined(self.armor)) {
    return;
  }

  self.armor.var_af2c34273f285356 = 2;
  self.armor.maxamountbonus = player_sp::function_e3627d4ae9fe9a89();
  player_sp::function_a11494e8ab9840d1();
}

function private function_637148cf0ac8fb4f() {
  assert(isPlayer(self));

  if(!isDefined(self.armor)) {
    return;
  }

  self.armor.var_af2c34273f285356 = 4;
  self.armor.maxamountbonus = player_sp::function_e3627d4ae9fe9a89() * 2;
  player_sp::function_a11494e8ab9840d1();
}

function private function_b9999eaf24c41513() {
  assert(isPlayer(self));

  if(!isDefined(self.armor)) {
    return;
  }

  self.armor.var_af2c34273f285356 = undefined;
  self.armor.maxamountbonus = undefined;
  player_sp::function_a11494e8ab9840d1();
}

function private set_magazine(extracount) {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_357cf5f77aeb3b5", extracount);
  weapons = level.player getweaponslist("\xe6\xaa6=\x93`Y");

  foreach(weapon in weapons) {
    currentstock = self getweaponammostock(weapon);
    maxstock = weaponmaxammo(weapon);

    if(extracount > 0) {
      currentstock = maxstock;
    } else {
      currentstock = int(min(currentstock, maxstock));
    }

    self setweaponammostock(weapon, currentstock, 1);
  }
}

function private function_fe246debca453b97() {
  set_magazine(1);
}

function private function_db2235f99c75c5ea() {
  set_magazine(2);
}

function private clear_magazine() {
  set_magazine(0);
}

function private function_1bf52b4994264a27() {
  assert(isPlayer(self));
  utility::setrecoilscale(0, 10);
}

function private function_acde4ff3edb1c53a() {
  assert(isPlayer(self));
  utility::setrecoilscale(0, 20);
}

function private function_68a81ba53ff0109c() {
  assert(isPlayer(self));
  utility::setrecoilscale(0, 0);
}

function private function_666b8fd48144d2b0() {
  val::set("[\xfftC\xaf\x17\xc5\x85N\xd6\xcc\xa5\xd8\xfb\xba\x8a\b", "[\xffR\b\v\x85\b\x8b\xe9\"\xf5\xf9", 0.85);
}

function private function_2f4fbff647c814a9() {
  val::set("[\xfftC\xaf\x17\xc5\x85N\xd6\xcc\xa5\xd8\xfb\xba\x8a\b", "[\xffR\b\v\x85\b\x8b\xe9\"\xf5\xf9", 0.75);
}

function private function_dc2225e06136c07b() {
  val::reset_all("[\xfftC\xaf\x17\xc5\x85N\xd6\xcc\xa5\xd8\xfb\xba\x8a\b");
}

function private function_e7fc4dc62a145b3c(scale) {
  assert(isPlayer(self));

  if(isDefined(self.gs)) {
    self.gs.basehealthexplosivedamagemultiplier = scale;
  }
}

function private function_5a1a3cd9ce961708() {
  function_e7fc4dc62a145b3c(0.75);
}

function private function_b148a7905de5b21() {
  function_e7fc4dc62a145b3c(0.5);
}

function private function_aec7fef0126408cf() {
  function_e7fc4dc62a145b3c(1);
}

function private function_fa1a68925036d08c() {
  level.var_c30117a8c477dafd = 1.3;
}

function private function_4aeece13a08563d5() {
  level.var_c30117a8c477dafd = undefined;
}

function private function_e284df1eee40b3e3() {
  level.var_d4ffe2f2ca5b7ee = 1;
}

function private function_f19763b4692cacf0() {
  level.var_d4ffe2f2ca5b7ee = undefined;
}

function private function_91f5b41b456ad496() {
  level.var_45c4efbf45a53bd = 1.5;
}

function private function_bf3688ec0a59b47b() {
  level.var_45c4efbf45a53bd = undefined;
}

function private set_ads(scale) {
  assert(isPlayer(self));

  if(!isDefined(self.var_7dee3e209418a752)) {
    self.var_7dee3e209418a752 = getdvarfloat(@ "hash_856fa3fe4152411c");
  }

  setsaveddvar(@ "hash_856fa3fe4152411c", scale);
}

function private function_caf9901d42a3a5bf() {
  set_ads(1.25);
}

function private function_e90ccec898f7e72() {
  set_ads(1.5);
}

function private function_cb01020c47e1922e() {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_856fa3fe4152411c", self.var_7dee3e209418a752 ?? 1);
}

function private function_6628d93c0be38cdf() {
  level.var_950679a3379371d0 = 0.6;
}

function private function_ce12e72597c87f12() {
  level.var_950679a3379371d0 = 0.2;
}

function private function_b1b9369b357a2c0c() {
  level.var_950679a3379371d0 = undefined;
}

function private function_3d1847c7c8b277ca(extracount) {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_bcd0fec29a9a2d47", extracount);
  equipment_wheel::function_7f5cfbd3540bbd6e();
  weapons = self getweaponslist("\x10\x89\xc9I\x96$\x8f");

  foreach(weapon in weapons) {
    currentclip = self getweaponammoclip(weapon);
    self setweaponammoclip(weapon, currentclip + extracount);
  }
}

function private function_b1f85a81ff5efff2() {
  function_3d1847c7c8b277ca(1);
}

function private function_6e611db2b873273f() {
  function_3d1847c7c8b277ca(2);
}

function private function_f684c5e41eff3a05() {
  setsaveddvar(@ "hash_bcd0fec29a9a2d47", 0);
  equipment_wheel::function_7f5cfbd3540bbd6e();
}

function private function_3ba4a0be4b05641() {
  level.var_5e954d29957e9bc2 = 1.15;
}

function private function_b9c3777dd6090b28() {
  level.var_5e954d29957e9bc2 = 1.25;
}

function private function_cd20a6f80d36c138() {
  level.var_5e954d29957e9bc2 = undefined;
}

function private function_7257c5bc392aa6a0() {
  level.var_4824dda5c6dc214a = 1;
}

function private clear_assassin() {
  level.var_4824dda5c6dc214a = undefined;
}

function private function_a5bd273d04429f4() {
  assert(isPlayer(self));
  player = self;
  player set_hipfire(0.75);
}

function private function_fdc9903382b54d5d() {
  assert(isPlayer(self));
  player = self;
  player set_hipfire(0.5);
}

function private clear_hipfire() {
  assert(isPlayer(self));
  player = self;
  player set_hipfire(1);
}

function private set_hipfire(spreadscale) {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_1ac1ae216ecbded5", spreadscale);
}

function private function_44690566eef9bc8f() {
  assert(isPlayer(self));
  player = self;
  player setperk("\x12\xc0\xc8\x99'\xb5\x99i\xc8\x80\xaf+\x96XK\xd0\xf1Ep\xdc\x17", 1);
  setsaveddvar(@ "hash_48a5711c3d32ab43", 0.9);
}

function private function_f7d40e4e4ef52a82() {
  assert(isPlayer(self));
  player = self;
  player setperk("\x12\xc0\xc8\x99'\xb5\x99i\xc8\x80\xaf+\x96XK\xd0\xf1Ep\xdc\x17", 1);
  setsaveddvar(@ "hash_48a5711c3d32ab43", 0.75);
}

function private clear_steady() {
  assert(isPlayer(self));
  player = self;
  player unsetperk("\x12\xc0\xc8\x99'\xb5\x99i\xc8\x80\xaf+\x96XK\xd0\xf1Ep\xdc\x17", 1);
}

function private function_c62c239223fca399() {
  assert(isPlayer(self));
  player = self;
  player setperk("\xa6T\x86\xdf6-<U\xba5\x85\x1d7cP\x83n\xa5\xe5bh\xf7Pb\x15\xccp", 1);
  setsaveddvar(@ "perk_bulletpenetrationmultiplier", 2);
}

function private function_fe86f591a63a8820() {
  assert(isPlayer(self));
  player = self;
  player setperk("\xa6T\x86\xdf6-<U\xba5\x85\x1d7cP\x83n\xa5\xe5bh\xf7Pb\x15\xccp", 1);
  setsaveddvar(@ "perk_bulletpenetrationmultiplier", 4);
}

function private clear_penetrate() {
  assert(isPlayer(self));
  player = self;
  player unsetperk("\xa6T\x86\xdf6-<U\xba5\x85\x1d7cP\x83n\xa5\xe5bh\xf7Pb\x15\xccp", 1);
}

function private function_dabb12a8651ac997() {
  assert(isPlayer(self));
  player = self;
  setsaveddvar(@ "hash_6a2b7b82ee4d1df4", 0.7);
}

function private clear_marksman() {
  assert(isPlayer(self));
  player = self;
  setsaveddvar(@ "hash_6a2b7b82ee4d1df4", 1);
}

function private function_4e74f8ad2b230fe9() {
  assert(isPlayer(self));
  player = self;
  level thread scavenger_thread(1.2);
}

function private clear_scavenger() {
  assert(isPlayer(self));
  player = self;
  level thread scavenger_thread(1);
}

function private scavenger_thread(rate = 1) {
  self notify("\xf2\b6\x9d\x03\x9f\x15#C\xd2\xea\xd6 \xf7\xb3s");
  self endon("\xf2\b6\x9d\x03\x9f\x15#C\xd2\xea\xd6 \xf7\xb3s");

  if(rate == 1) {
    return;
  }

  while(true) {
    self waittill("EN\xd6X\xc9\xe6\xfe\x8fB/\x1a\x04\x1a\xde\xd2#\x96", droppedweaponentity);

    if(!isDefined(droppedweaponentity)) {
      continue;
    }

    ammocounts = droppedweaponentity itemweapongetammo();

    if(isDefined(ammocounts["5)\xe1\xcb\x99\xf5\xb0-T\x88"])) {
      ammocounts["5)\xe1\xcb\x99\xf5\xb0-T\x88"] = int(ammocounts["5)\xe1\xcb\x99\xf5\xb0-T\x88"] * rate);
      droppedweaponentity itemweaponsetammo(ammocounts["\x111Go\x9cA?\xba\xae"] ?? 0, ammocounts["5)\xe1\xcb\x99\xf5\xb0-T\x88"]);
    }

    if(isDefined(ammocounts["\xd3p\xf7\x91\x9e\xe2\xe7\xde\xd8|\xbf\xc2\x91B"])) {
      ammocounts["\xd3p\xf7\x91\x9e\xe2\xe7\xde\xd8|\xbf\xc2\x91B"] = int(ammocounts["\xd3p\xf7\x91\x9e\xe2\xe7\xde\xd8|\xbf\xc2\x91B"] * rate);
      droppedweaponentity itemweaponsetammo(ammocounts["[C\\i\x1c\x9d$a\rd6\xf3\xfc"] ?? 0, ammocounts["\xd3p\xf7\x91\x9e\xe2\xe7\xde\xd8|\xbf\xc2\x91B"], undefined, 1);
    }
  }
}

function private function_7491d643f1fe631e() {
  assert(isPlayer(self));
  player = self;
  player thread gunner_thread(1.25);
}

function private clear_gunner() {
  assert(isPlayer(self));
  player = self;
  player notify("D\xf7\x18\xf8p\xc3} \x02\x95\x05\x9d\x99");
  player val::reset_all("<i\x8f\xba\xea\x0f");
}

function private gunner_thread(rate) {
  self notify("E\x12\x96/\xc2\x15;\xe3\x03n\xad\x02/\xb2\xa0\\");
  self endon("E\x12\x96/\xc2\x15;\xe3\x03n\xad\x02/\xb2\xa0\\");
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("D\xf7\x18\xf8p\xc3} \x02\x95\x05\x9d\x99");
  player gunner_update(player getcurrentweapon(), rate);

  while(true) {
    player waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", weapon);
    player gunner_update(weapon, rate);
  }
}

function private gunner_update(weapon, rate) {
  assert(isPlayer(self));
  player = self;

  if(isweapon(weapon)) {
    weapclass = weapon getweaponclassint();

    switch (weapclass) {
      case 3:
      case 8:
        player val::set("<i\x8f\xba\xea\x0f", "\x8f}T\xa3\xdc>\x9a<\\'\xe04$\x9eG{\xf2\x81\xf59S", rate);
        break;
      default:
        player val::reset_all("<i\x8f\xba\xea\x0f");
        break;
    }
  }
}
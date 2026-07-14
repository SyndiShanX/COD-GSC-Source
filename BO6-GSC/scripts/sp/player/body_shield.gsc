/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\body_shield.gsc
*********************************************/

#using script_53f4e6352b0b2425;
#using script_758eb3e6844a19b3;
#using scripts\common\ai;
#using scripts\common\animbank;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\engine\easing;
#using scripts\engine\hud_management;
#using scripts\engine\scriptable_door;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\player;
#using scripts\sp\player\body_carry;
#using scripts\sp\player\carrylinked;
#using scripts\sp\player\takedown_style;
#namespace body_shield;

function private autoexec __init__system__() {
  system::register(#"body_shield", #"takedown_style", &pre_main, undefined);
}

function private pre_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  if(!isDefined(level.body_shield)) {
    level.body_shield = spawnStruct();
    level.body_shield.collisioncontents = physics_createcontents(["vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "M\xdb^{\xbe\x7fQ;\xe3\x1f\vB\xd5~\x8aE\xdc\x95\x02\xf3\xd1\xafc\xc9\xde\xdb\n"]);
    level.body_shield.var_baaf51519bdfbe6f = physics_createcontents(["vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "M\xdb^{\xbe\x7fQ;\xe3\x1f\vB\xd5~\x8aE\xdc\x95\x02\xf3\xd1\xafc\xc9\xde\xdb\n"]);
    level.takedown_grabs = takedown::function_8a4e4c7b88eefbd2("I60\xc9\x86{K\xc9\xe63v[\xacEaO\xcc)Q\x84\x16\x11\xb3\x7f\xd3\xc1\x93U\x9e");
    level.var_fac1b77431f3636a = &function_6904655757a58cfd;

    setdvarifuninitialized(@ "hash_f0f3335490c9779", "<dev string:x24>");

    setdvarifuninitialized(@ "hash_69136862fd6c1121", 0);

    setdvarifuninitialized(@ "hash_26c518dff1e97f80", 0);

    setdvarifuninitialized(@ "hash_a37e44bb012e874f", 0);

    setdvarifuninitialized(@ "hash_24510ee17cc351bf", 0);
  }
}

function private function_6904655757a58cfd(scene_root, victim) {
  assert(isPlayer(self));
  assert(isstruct(scene_root) || isent(scene_root));
  assert(isDefined(scene_root.origin));
  assert(isDefined(scene_root.angles));
  player = self;
  player notify("|\xf3\x81\x8e\xa9\xe2W\x94\x94\xd6\"\xdcn8:\xac\xacC\x05\xff");
  player carrylinked::function_a3ff6abe6c4553c9();
  snd::transient_load("\xc1\xd6S?]H\xc0%\xb8|\xb2\xf2\xd2 \x19\x11\xb5");
  player val::set("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86", "\xcb\xd8\x17e\xf60Q\x02\x1f\xbd\xfd\x1e\xcb\xe5", 0);

  debugscene = getDvar(@ "hash_f0f3335490c9779", "<dev string:x24>");

  if(debugscene != "<dev string:x24>" && isDefined(getscriptbundle("<dev string:x28>" + debugscene))) {
    player.takedown.var_ecfd49546c4f9e70 = [debugscene];
  }

  if(!isDefined(player.takedown.var_ecfd49546c4f9e70) || player.takedown.var_ecfd49546c4f9e70.size == 0) {
    return;
  }

  grab_scene = player.takedown.var_ecfd49546c4f9e70[0];
  player utility::ent_flag_set("#\xb1\xbb\x16\xb8\xbd\xbe\xcd\xder\x1d\x12\x16\xd6\x99-\x93x");
  player.takedown.body_shield = spawnStruct();
  player.takedown.body_shield.model = victim.model;
  player.takedown.body_shield.classname = victim.classname;
  player.takedown.body_shield.spawner = victim.spawner;
  player.takedown.body_shield.weaponinfo = victim.weaponinfo;
  player.takedown.body_shield.ainame = victim.ainame;
  player.takedown.body_shield.health = 70;
  player.takedown.body_shield.healthmax = player.takedown.body_shield.health;
  player.takedown.body_shield.var_b096d1c105075816 = player.takedown.body_shield.health;
  player.takedown.body_shield.var_5553c10637001629 = gettime();
  player.takedown.body_shield.body = player carrylinked::function_3ddcf99ca8b9668d(victim);
  player.takedown.body_shield.body hide();
  player val::set_array("/\x1f\xc7\x96\xfc\xc8\x12P<k\x8b\xb7p\x1b\xdbo", level.takedowns.var_9a71c163c51b754f, 0);
  player val::set("/\x1f\xc7\x96\xfc\xc8\x12P<k\x8b\xb7p\x1b\xdbo", "\x1c\xe3\x88@\x7f%G\x17\xef{V\xb1\xab\xb9t8", 0);
  player thread carrylinked::gesture_wait();
  player function_dd8ebd85f099bbc0(victim);
  player thread earthquake_listen();
  scene_root scene::play([player, victim], undefined, grab_scene);
  player notify("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb");
  player player_sp::function_a9a4c8a5f556afa7(player.takedown.start_origin, undefined, [player, victim]);
  player.takedown.body_shield.body show();
  player.takedown.body_shield.damagedisperse = player_sp::dispersedamagepush(&disperse_damage);
  setsaveddvar(@ "hash_7835f2c29003abeb", -0.5);
  player function_c9bcf0b09e49206b(1, 0);

  if(isDefined(victim)) {
    victim.ignoreme = 1;
    victim.ignoreall = 1;
    victim.pacifist = 1;
    victim.dontattackme = 1;
    victim.diequietly = 1;
    victim.in_melee_death = 1;
    victim.battlechatterallowed = 0;
    victim.dontmelee = 1;
    victim.syncedmeleetarget = undefined;
    victim.maxsightdistsqrd = 1;
    victim.fixednode = 0;
    victim.newenemyreactiondistsq = 0;
    victim.remove_from_animloop = 1;
    victim.var_3aa831911040255c = 1;

    if(isDefined(victim.stealth)) {
      victim.stealth.last_goal = undefined;
      victim.fnstealthgotonode = undefined;
      victim.target = undefined;
    }

    victim invisiblenotsolid();
    victim linkTo(player);
    victim function_27f9ab76b6cc6c3d();
    player.takedown.body_shield.victimai = victim;
  }

  player.takedown.body_shield.body val::set("\x91T\xf1\xc4\xe0\x9c\x89\x1a\xa9\x91\x1c\xed~o\x03\x0f\xc6D", "d\xbc;\x03\x90\xa7\xde\xc6\xef\xb2z\xcb]\xc1\x15\x97\x1f", 1);
  player carrylinked::begin("bNH\x82P\xa6\xcc\x96\xfb'\xc7\x94\xa1\n\xe8\x19\xbd\xd4", player.takedown.body_shield.body);
  player.takedown.body_shield.body val::reset_all("\x91T\xf1\xc4\xe0\x9c\x89\x1a\xa9\x91\x1c\xed~o\x03\x0f\xc6D");
  player childthread function_62d0215baa798628();
  player thread function_8a8ad5a17f78712f(player.takedown.body_shield.victimai);
  player thread function_936f3840c12103e6();
}

function private earthquake_listen() {
  self notify("Kk\xbc\xefG6\x1e\x0e\xf1\xb0e\xd6\xacfR\x1f");
  self endon("Kk\xbc\xefG6\x1e\x0e\xf1\xb0e\xd6\xacfR\x1f");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\x1c6\x16\x97\x95N\xaf\x98\xedd\xe5\xaf\xcd4Z\xac6\xc8_ccYa\xb9\xea\xe0");
  self waittill("\x88\xf0\xb27\xf2\xd2^N\xd9\xeb", scale, how_long);
  scale = isDefined(scale) ? float(scale) : 0.4;
  how_long = isDefined(how_long) ? float(how_long) : 1;
  self earthquakeforplayer(scale, how_long, self.origin, 100);
  self playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
}

function private disperse_damage(node, damage, attacker, direction, point, type, objweapon, inflictor, dflags) {
  player = self;

  switch (type) {
    case #"hash_1f00b716e2ac2e39":
    case #"hash_3c20f39c73a1422b":
    case #"hash_571e46e17a3cf2e3":
    case #"hash_5f1054c48d66fd1c":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_966768b3f0c94767":
    case #"hash_a86d8c43482948a4":
    case #"hash_a911a1880d996edb":
    case #"hash_c22b13f81bed11f0":
    case #"hash_d8646db4e6ee3658":
      if(vectordot(direction, anglesToForward(player getplayerangles())) < -0.5) {
        isexplosive = player_sp::isexplosivedamage(type);
        min_time = 2;
        time_slice = 300;
        var_180720b4fe9c17eb = player.takedown.body_shield.healthmax / min_time;
        var_54ddd5d09214c48 = var_180720b4fe9c17eb / 1000 / float(time_slice);

        if(getdvarint(@ "hash_24510ee17cc351bf", 0)) {
          damage = 0;
        }

        new_health = player.takedown.body_shield.health - damage;

        if(isexplosive) {
          new_health = max(new_health, 0);
        } else {
          new_health = max(new_health, player.takedown.body_shield.var_b096d1c105075816 - var_54ddd5d09214c48);
        }

        if(gettime() - player.takedown.body_shield.var_5553c10637001629 > time_slice || isexplosive) {
          player.takedown.body_shield.var_b096d1c105075816 = new_health;
          player.takedown.body_shield.var_5553c10637001629 = gettime();
        }

        player.takedown.body_shield.health = new_health;
        function_c9bcf0b09e49206b(self.takedown.body_shield.health / self.takedown.body_shield.healthmax, 0);

        if(!isexplosive) {
          var_d04e846f7c7f7885 = "\xe2\xbb\xa6\xc1A!\fW\xcf;\x04\xb7\xcd6+\x1b\n8\xc5\x06;_\xf3\x8d";

          if(soundexists(var_d04e846f7c7f7885)) {
            snd::play(var_d04e846f7c7f7885, player);
          }
        }

        if(getdvarint(@ "hash_69136862fd6c1121", 0)) {
          iprintlnbold("<dev string:x3e>" + damage);
        }

        player notify("\xd8\x93\xa2;G\xed^\x16tx\fS\xb8\xb8\x872\xd4[", damage);
        player.carrylinked.paintime = gettime();

        if(player.takedown.body_shield.health <= 0) {
          player notify("\xe9\xc0\xcff\xcfPf\xed\xd0\x91\xeepOs\xb0\x95\x14\x9c9*\xf5\xbd");
          return;
        }

        if(type != "\b\x89z\xc1\xf1\xd4I\xf3") {
          return;
        }
      }

      break;
    default:
      break;
  }

  return player player_sp::dispersedamage(node.prev, damage, attacker, direction, point, type, objweapon, inflictor, dflags);
}

function private function_6370e7bfc34da060() {
  self endon("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  tick_time = 1.5;
  decay_time = 14000;
  start_time = gettime() - tick_time * 1000;
  prev_health = self.takedown.body_shield.health;

  for(result = undefined; true; result = utility::waittill_notify_or_timeout("\xd8\x93\xa2;G\xed^\x16tx\fS\xb8\xb8\x872\xd4[", 1)) {
    if(!isDefined(result) || result != "\xd8\x93\xa2;G\xed^\x16tx\fS\xb8\xb8\x872\xd4[") {
      time_pct = clamp((gettime() - start_time) / decay_time, 0, 1);
      health_decay = prev_health - easing::ease_power(self.takedown.body_shield.healthmax, 0, time_pct, 1, 1, 2);
      decay_pct = health_decay / self.takedown.body_shield.healthmax;
      self.takedown.body_shield.health -= health_decay;
      prev_health -= health_decay;
      self.takedown.body_shield.var_b096d1c105075816 = self.takedown.body_shield.health;
      self.takedown.body_shield.var_5553c10637001629 = gettime();
      health_pct = self.takedown.body_shield.health / self.takedown.body_shield.healthmax;

      if(health_pct < 0.05) {
        health_pct = 0;
      }

      function_c9bcf0b09e49206b(health_pct, tick_time);

      if(health_pct <= 0) {
        wait tick_time;
        self notify("\xe9\xc0\xcff\xcfPf\xed\xd0\x91\xeepOs\xb0\x95\x14\x9c9*\xf5\xbd");
        return;
      }

      tick_time = 1;
    }
  }
}

function private function_5401a7701fc35044() {
  self notify("6P\xfd\xb8g\xcc\xc6\xa3\xeb\x97`\xf5x\xe4\\$");
  self endon("6P\xfd\xb8g\xcc\xc6\xa3\xeb\x97`\xf5x\xe4\\$");
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");

  while(true) {
    waitframe();

    if(player isparachuting() || player isskydiving() || player isonladder() || player isswimming()) {
      player thread player_body_shield_cleanup(1);
      break;
    }
  }
}

function private function_62d0215baa798628() {
  self notify("\xa9Y\xd1>\xda;\x96\xe0\xd9D\xb2U\x18,\xdc*");
  self endon("\xa9Y\xd1>\xda;\x96\xe0\xd9D\xb2U\x18,\xdc*");
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("\x1c6\x16\x97\x95N\xaf\x98\xedd\xe5\xaf\xcd4Z\xac6\xc8_ccYa\xb9\xea\xe0");
  player thread function_5401a7701fc35044();

  while(true) {
    result = player utility::waittill_any_return("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "\xe9\xc0\xcff\xcfPf\xed\xd0\x91\xeepOs\xb0\x95\x14\x9c9*\xf5\xbd", "\xc7?\x16|\x01\x84\xca\xbb\xb5\xdf\xc7\xb0\xec\xb0\xb7\xb0\x89:D\x17");

    if(result == "\xc7?\x16|\x01\x84\xca\xbb\xb5\xdf\xc7\xb0\xec\xb0\xb7\xb0\x89:D\x17" && !player utility::ent_flag("\xc7?\x16|\x01\x84\xca\xbb\xb5\xdf\xc7\xb0\xec\xb0\xb7\xb0\x89:D\x17")) {
      continue;
    }

    player notify("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");
    player function_8f9842d2ab69d0b6();

    if(isDefined(player.takedown.body_shield.damagedisperse)) {
      player_sp::dispersedamagepop(player.takedown.body_shield.damagedisperse);
      player.takedown.body_shield.damagedisperse = undefined;
    }

    setsaveddvar(@ "hash_7835f2c29003abeb", 1);
    player function_dd8ebd85f099bbc0(undefined);

    switch (result) {
      case #"hash_690a35f62fe93e78":
      default:
        player val::set("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
        exitgesture = "\xbaCxqC\xd4,^A/\xcd\xcdL@\xc0d\x96\xd3\xcc\xb2\xaa\xbb\x8cq\xedg\x9e\xa4s\xb6\x87\x7f\xba\xba";
        player thread carrylinked::gesture_play(exitgesture);
        earlyragdoll = spawnStruct();
        earlyragdoll.entity = player.takedown.body_shield.body;
        earlyragdoll.collision_tags = ["\xc1\xaf\x82\xc1\t\xf9", "\xa7>4.\x83\x91\xac\x10", "\f\xf4\x8e\xbeZ\x98i0"];
        earlyragdoll.collision_radius = 5;
        earlyragdoll.groundclearance = 16;
        player carrylinked::end(undefined, "~Cn\x16\xa0$\xbbu\xf15@\xd1:", earlyragdoll);
        level.player clearsoundsubmix("n8}\xa3\xc4\x03_b\xdb#\xe5n\x1a-+\x1bF\xf5\xc8\xear\xb0\xe8\xd2\xed\x9b");

        if(isent(player.takedown.body_shield.victimai)) {
          victim = player.takedown.body_shield.victimai;
          victim val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");
        }

        break;
      case #"hash_4c1d7ca74851ad65":
        player val::set("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
        exitgesture = "\x9d+\xb9\xeb;\xb5\xaf7C\xd2V\xd8d_&\xb72\x97}cK\xcd\xd6\xb2\x19_\x8e\xca\x9c\xad\xb47aG\x95";
        player thread carrylinked::gesture_play(exitgesture);
        earlyragdoll = spawnStruct();
        earlyragdoll.entity = player.takedown.body_shield.body;
        earlyragdoll.collision_tags = ["\xc1\xaf\x82\xc1\t\xf9", "\xa7>4.\x83\x91\xac\x10", "\f\xf4\x8e\xbeZ\x98i0"];
        earlyragdoll.collision_radius = 5;
        earlyragdoll.groundclearance = 16;
        player carrylinked::end(undefined, "\x8c\xc9o\x1c}:VN\xb6-n,\xd1\x95", earlyragdoll);
        level.player clearsoundsubmix("n8}\xa3\xc4\x03_b\xdb#\xe5n\x1a-+\x1bF\xf5\xc8\xear\xb0\xe8\xd2\xed\x9b");

        if(isent(player.takedown.body_shield.victimai)) {
          victim = player.takedown.body_shield.victimai;
          victim val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");
        }

        break;
      case #"hash_48eed8fd5bd2e1c2":
        exitgesture = "\xee\xf6\x11\xe0\x0f\xa6\xb3\x8d+ \xfa\xc7\x8e2\xb7?\xf9m\x05]\xe8`\x18'=\xf57\xa1\xff\v2\xc8\x8a\xff\t\xc4\x1e\xd7";
        player val::set_array("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", level.takedowns.var_9a71c163c51b754f, 0);
        player val::set("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "6\xb5g\x16\xa9\xc9\xab\xc7/\x12", 0);
        player val::set("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
        player val::set("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", 0);
        player val::set("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "\x1c\xe3\x88@\x7f%G\x17\xef{V\xb1\xab\xb9t8", 0);
        player thread carrylinked::gesture_play(exitgesture);
        player thread carrylinked::gesture_wait(player, "\xacQi\x0e@\xa3?[\xa9k\xc6g\xfd(Q`\xec\xc6^\x95q");
        player function_40a018f610a48431();
        player val::reset_all("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84");
        level.player clearsoundsubmix("n8}\xa3\xc4\x03_b\xdb#\xe5n\x1a-+\x1bF\xf5\xc8\xear\xb0\xe8\xd2\xed\x9b");
        player thread body_shield_watch_for_early_deletion_during_grenade();
        player function_90aab9789ebd9cd0(player.takedown.body_shield.body);

        if(isent(player.takedown.body_shield.victimai) && !utility::is_dead_or_dying(player.takedown.body_shield.victimai)) {
          victim = player.takedown.body_shield.victimai;

          if(isDefined(victim.magic_bullet_shield)) {
            victim ai::stop_magic_bullet_shield();
          }

          victim val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");
          victim kill(player.takedown.body_shield.grenade_origin, player, player, "\x9az\x88\xfat)*\xe4\x14\x11\x15");
          victim startragdoll();
        } else if(!isent(player.takedown.body_shield.victimai) && isDefined(player.takedown.body_shield.body)) {
          player.takedown.body_shield.body show();
        }

        if(player isgestureplaying(exitgesture)) {
          player notify("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb");
          player stopgestureviewmodel(exitgesture);
        }

        break;
      case #"hash_f853abc25fc0660b":
        player carrylinked::end(1, "\x8c\xc9o\x1c}:VN\xb6-n,\xd1\x95");
        break;
    }

    player thread player_body_shield_cleanup();
    break;
  }
}

function private function_40a018f610a48431() {
  assert(isPlayer(self));
  abspitch = abs(angleclamp180(self getplayerangles()[0]));
  duration = abspitch / 180;
  prep = undefined;

  if(abspitch > 0) {
    prep = utility::spawn_tag_origin(self.origin, self.angles);
    self playerlinktoblend(prep, "\xec\xbfK|\au\xcd\xc2\x19<", duration, duration * 0.5, duration * 0.5);
  }

  carrylinked::end(undefined, "\xc8r\xbdp\xbe\xec\x9ce7\xc2\x19e", undefined, duration, 1);

  if(isDefined(prep)) {
    prep delete();
  }
}

function private function_8f9842d2ab69d0b6() {
  player = self;
  player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "\x8e\f\xe4I");
  player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", ",\xe1\x93So\x98\r");
  player notifyonplayercommandremove("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "\xe88-\x97\xb82a");
  player notifyonplayercommandremove("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "z\xf5\xbaH \x13\xbeo\x87");
  player notifyonplayercommandremove("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "b\x06\xaa`]\xbc\xf5>\xa5\xb5\xff*p");
  player notifyonplayercommandremove("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "n-\xa2\xff\xb9");
  refname = "^!;)\xb2a\xea\xa8is)!\xe5*{X\xf9\x89";

  if(player hud_management::function_48c98ea9a4f0da89(refname)) {
    player hud_management::scripted_widget_destroy(refname);
  }
}

function private function_936f3840c12103e6() {
  self notify(" UM\xba\xf3b3WG%\xa3& 3\x1d\xb00");
  self endon(" UM\xba\xf3b3WG%\xa3& 3\x1d\xb00");
  player = self;
  player endon("\x1c6\x16\x97\x95N\xaf\x98\xedd\xe5\xaf\xcd4Z\xac6\xc8_ccYa\xb9\xea\xe0");
  player endon("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");
  player waittill("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(isDefined(player.takedown.body_shield)) {
    player thread player_body_shield_cleanup(1);
  }
}

function private player_body_shield_cleanup(earlyexit) {
  self notify("\xd4\xcc\xcd\xef\x8c^mI\xc7\xd7\x95\xb7I\xd1Re");
  self endon("\xd4\xcc\xcd\xef\x8c^mI\xc7\xd7\x95\xb7I\xd1Re");
  player = self;
  assert(isPlayer(player));
  player thread carrylinked::wait_to_revert_demeanor();

  if(istrue(earlyexit) && isDefined(player.takedown.body_shield)) {
    function_8f9842d2ab69d0b6();

    if(isDefined(player.takedown.body_shield.damagedisperse)) {
      player_sp::dispersedamagepop(player.takedown.body_shield.damagedisperse);
      player.takedown.body_shield.damagedisperse = undefined;
    }

    setsaveddvar(@ "hash_7835f2c29003abeb", 1);
    player function_dd8ebd85f099bbc0(undefined);
  }

  refname = "^!;)\xb2a\xea\xa8is)!\xe5*{X\xf9\x89";

  if(player hud_management::function_48c98ea9a4f0da89(refname)) {
    player hud_management::scripted_widget_destroy(refname);
  }

  if(isDefined(player.carrylinked)) {
    player carrylinked::end(1, "\x8c\xc9o\x1c}:VN\xb6-n,\xd1\x95");
  }

  victim = player.takedown.body_shield.victimai;

  if(isent(victim)) {
    if(isDefined(victim.magic_bullet_shield)) {
      victim ai::stop_magic_bullet_shield();
    }

    victim val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");

    if(isDefined(player.takedown.body_shield.body)) {
      victim.nodrop = 1;
      victim.allowdeath = 1;
      victim.var_5061aef10be4384a = 1;
      victim kill((0, 0, 0), player, player, "\x13\x1e\xe31{\xb4\xf1\x85\x18");
      waitframe();

      if(isent(victim)) {
        victim unlink();
        victim delete();
      }
    }
  }

  if(isDefined(player.takedown.body_shield.body)) {
    noblood = player isswimming() && istrue(earlyexit);
    player.takedown.body_shield.body startragdoll();
    player.takedown.body_shield.body body_carry::delayedcorpseenable(noblood);
  }

  if(istrue(player.takedown.body_shield.var_465d9063611f1221)) {
    destroynavrepulsor("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86");
  }

  player val::reset_all("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86");
  player utility::ent_flag_clear("#\xb1\xbb\x16\xb8\xbd\xbe\xcd\xder\x1d\x12\x16\xd6\x99-\x93x");
  player.takedown.body_shield = undefined;
  player notify("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");
  player notify("\x1c6\x16\x97\x95N\xaf\x98\xedd\xe5\xaf\xcd4Z\xac6\xc8_ccYa\xb9\xea\xe0");
}

function private body_shield_watch_for_early_deletion_during_grenade() {
  player = self;
  victim = player.takedown.body_shield.victimai;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  victim notify("\xf2O\x0e4\xc5\xbf\x8a\x14T\xc8\xdb\ah\x9e\xcc\xb7%\xeb\xfe\xc0g\x1d'B\xee\x1ar\x10\x157\xf0\xf7\x9f\xcc*l\x82~\xb6\xda\x06D\xc1`\xc3\x156Yi\x1e\xfe");
  victim endon("\xf2O\x0e4\xc5\xbf\x8a\x14T\xc8\xdb\ah\x9e\xcc\xb7%\xeb\xfe\xc0g\x1d'B\xee\x1ar\x10\x157\xf0\xf7\x9f\xcc*l\x82~\xb6\xda\x06D\xc1`\xc3\x156Yi\x1e\xfe");
  victim endon("*nb/P\aO\x12Q\xee\x10Qw\xf6\xc4!\xea\xc4\xe5\xb7\xbb<\xae\x90\x93\xcf!");
  victim endon("\x1e\xfd\xd1\xa2\a");
  waitframe();

  while(isDefined(player.takedown.body_shield.body)) {
    player.takedown.body_shield.body.origin = victim.origin;
    player.takedown.body_shield.body.angles = victim.angles;
    waitframe();
  }
}

function private function_34037569753e5b3c(body) {
  player = self;
  victim = player.takedown.body_shield.victimai;
  player.takedown.body_shield.body hide();
  victim motionwarpcancel();
  victim unlink();
  victim visiblesolid();
  victim animmode("\xceW{\x1bX\x16\xbc}\x87\xdd\xbd\xa4\x17\xe8\xbb");
  victim.diequietly = 0;
  return victim;
}

function private function_90aab9789ebd9cd0(body) {
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player carrylinked::allow_weapon(0);
  victim = player function_34037569753e5b3c(body);
  victim endon("\x1e\xfd\xd1\xa2\a");
  scene_root = spawnStruct();
  scene_root.origin = player.origin;
  scene_root.angles = player.angles;
  animversion = randomint(2);
  animnamestrings[0] = "\xcds\xbb\xb7\x18{2(\xb6[\xf1[\x11";
  animnamestrings[1] = "\xf3\xe6\x86\xd9\xb4/\x15\xf9\xd8\xb5\xec\\\xf2";
  victim.var_f70e23be8eea93e5 = animnamestrings[animversion];
  victim thread function_9f2fae462652a308();
  scene_root scene::play([player, victim], undefined, "\xf2\x16eu9.+\xcdv \xb4l\r\x1d\xbb*\xc5\x96\x85\x82\xd8\xe2N\x10s\xc0\xabN\xf6\x97\xe7>\x93\x15\xb9NAm\x18\x875");

  if(istrue(player.takedown.body_shield.var_465d9063611f1221)) {
    destroynavrepulsor("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86");
    player.takedown.body_shield.var_465d9063611f1221 = undefined;
  }

  victim waittill("\x9c\xdf&U\xb9%!h\x11S\xd7\xbfB\x89\xd8\f\xed>\xfb\xdas\xe1\xdb\x874P\xf0t\xcb>\xd3\xab\x9b]\x81\x95");
}

function private function_9f2fae462652a308() {
  self notify("3C\x83\x03E\xb7w\x90\xb7\x7f\xb7E\x01\xe0*)");
  self endon("3C\x83\x03E\xb7w\x90\xb7\x7f\xb7E\x01\xe0*)");
  victim = self;
  victim endon("\x1e\xfd\xd1\xa2\a");
  waitframe();
  victim utility::function_18e9f1084badc1c7("Yj\xd3mH4\xc3\xb5\x80zq\xc6");
  victim stopanimScripted();
  victim thread function_53b2b00fe62c75f7();
  victim utility::script_func("z\x9b5wF\xe4\x93\xb5\xd5l\xefq\xb1\xfd", &function_fd364d97c667c044);
}

function private function_53b2b00fe62c75f7() {
  self notify("\xef\x88\x1c\xe2\xa0\xc0\xddk^3\xfe\x9e\x9e\x94bo");
  self endon("\xef\x88\x1c\xe2\xa0\xc0\xddk^3\xfe\x9e\x9e\x94bo");
  player = level.player;
  victim = self;
  victim endon("\x1e\xfd\xd1\xa2\a");
  player endon("\x9c\xdf&U\xb9%!h\x11S\xd7\xbfB\x89\xd8\f\xed>\xfb\xdas\xe1\xdb\x874P\xf0t\xcb>\xd3\xab\x9b]\x81\x95");
  assert(isent(victim));
  last_position = victim.origin;

  while(true) {
    waitframe();
    move_delta = victim.origin - last_position;
    move_delta = (move_delta[0], move_delta[1], 0);
    last_position = victim.origin;

    if(lengthsquared(move_delta) < 0.01) {
      continue;
    }

    move_dir = vectorNormalize(move_delta);
    interactables = getaiarrayinradius(victim.origin, 80);

    foreach(guy in interactables) {
      if(isai(guy) && !istrue(guy.var_34a1ace987b363bb) && guy != victim) {
        dir = guy.origin - victim.origin;
        dir = vectorNormalize((dir[0], dir[1], 0));
        dot = vectordot(move_dir, dir);

        if(!guy val::get("T\xbf\x84KN\xc6\xc9\x97mk\xd33\xa9\xb4\xf5")) {
          continue;
        }

        if(dot > 0.866025) {
          dot_right = vectordot(vectorcross(move_dir, (0, 0, 1)), dir);

          if(dot_right > 0) {
            dir = rotatevector(move_dir, (0, -45, 0));
          } else {
            dir = rotatevector(move_dir, (0, 45, 0));
          }

          if(istrue(getdvarint(@ "hash_26c518dff1e97f80", 0))) {
            duration = 1000;
            sphere(victim.origin, 2, (0, 1, 0), 1, duration);
            sphere(victim.origin, 2, (1, 0, 0), 1, duration);
            line(victim.origin, victim.origin + guy.origin - victim.origin, (1, 1, 1), 1, 1, duration);
            line(guy.origin, guy.origin + dir * 20, (1, 0, 0), 1, 1, duration);
          }

          guy.var_a708ed7f30b53c0b = vectortoangles(dir)[1] + 180;
          guy utility::script_func("z\x9b5wF\xe4\x93\xb5\xd5l\xefq\xb1\xfd", &function_8e00609a1b57f98c);
        }
      }
    }

    predictednextorigin = victim.origin + move_delta;
    doors = getentarrayinradius("r\x8e\x9d\x1c\t\x94\xc9\v;\xb5d}Hu;\x06", #script_noteworthy, predictednextorigin, 70, 1);

    foreach(door in doors) {
      if(isDefined(door) && door utility::ent_flag("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd")) {
        if(door.locked || door.bashed || door.open_completely || door.breached || door door_internal::door_is_half_open()) {
          continue;
        }

        door thread door_sp::door_bash_open(victim);
      }
    }

    scriptabledoor = function_b7f4e385296ba38a(predictednextorigin, 70);

    if(isDefined(scriptabledoor) && scriptabledoor isscriptableinstance()) {
      if(!scriptabledoor function_f1b3bf749ee83925() && !scriptable_door::function_d1da7e6857609614(scriptabledoor)) {
        scriptabledoor function_a7fcd5f2a8a27ab5("\xca\xed\x88\xa9", victim.origin);
      }
    }

    zoffset = (0, 0, 16);
    radius = 16;
    height = 40;
    tracestart = victim.origin + zoffset;
    traceend = predictednextorigin + zoffset;
    trace = trace::capsule_trace(tracestart, traceend, radius, height, undefined, [player, victim], level.body_shield.var_baaf51519bdfbe6f, 1);
    facingdir = anglesToForward(victim.angles);
    dotwall = vectordot(facingdir, trace["+0a<s,"]);
    dotfwd = vectordot(facingdir, move_dir);
    anim_name = undefined;
    victim_orient = undefined;

    if(!isDefined(trace["\x1f\xa8\x10WP\xa9"]) && trace["\xda\x16\x81\aw}^i"] < 1 && abs(trace["+0a<s,"][2]) < 0.5) {
      anim_name = dotwall > 0 ? "\xf8tQ\xc4.=>\xc8\xe0'\xd6H\xb6" : "\xa7\xae^\xaad\xadq\xcb\xc7IQ\xa0\xc6\xe9";
      victim.var_fe00a0ed17a6575d = 1;
      victim animmode("\x1b\x9e\x86\xecr\x97\xa2");

      if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
        duration = 500;
        trace::draw_trace(trace, (1, 1, 1), 1, duration);
        facevect = facingdir * 30;
        voriginoffset = victim.origin + zoffset;
        line(voriginoffset, voriginoffset + facevect, (0, 0, 1), 1, 1, duration);
        sphere(voriginoffset + facevect, 2, (0, 0, 1), 1, duration);
        normalvect = trace["<dev string:x57>"] * 30;
        line(voriginoffset, voriginoffset + normalvect, (0, 1, 0), 1, 1, duration);
        sphere(voriginoffset + normalvect, 2, (0, 1, 0), 1, duration);
      }
    } else if(trace["\xda\x16\x81\aw}^i"] >= 1) {
      traceendfar = tracestart + move_delta * 1.5;
      trace = trace::capsule_trace(traceend, traceendfar, radius, height, undefined, [player, victim], level.body_shield.var_baaf51519bdfbe6f);

      if(trace["\xda\x16\x81\aw}^i"] >= 1) {
        tracestart = traceendfar;
        traceend = tracestart + zoffset * -3;
        trace = trace::ray_trace(tracestart, traceend, [player, victim], level.body_shield.var_baaf51519bdfbe6f);

        if(trace["\xda\x16\x81\aw}^i"] >= 1) {
          victim.var_fe00a0ed17a6575d = 1;

          if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
            duration = 750;
            sphere(tracestart, 3, (1, 0, 0), 1, duration);
            line(tracestart, tracestart + move_dir * 30, (1, 1, 1), 1, 1, duration);
            line(tracestart, tracestart + facingdir * 30, (1, 0, 0), 1, 1, duration);
          }

          anim_name = dotfwd > 0 ? "\xee\x9d\x9bq\x99\xd2I\x80\x9e\x11" : "\xc4_\x182\a\xaaa\xbbK";
          dokill = 1;

          if(abs(dotfwd) < 0.7) {
            crossvector = vectorcross(move_dir, facingdir);
            anim_name = crossvector[2] > 0 ? "\xcb\xc8\xed\xe9\x8fSH\x94c\x14" : "i[`\xd6\xf4\xacX\x9e\x8c";
          } else {
            assert(1);
          }

          if(anim_name == "\xee\x9d\x9bq\x99\xd2I\x80\x9e\x11") {
            victim_orient = vectortoangles(move_dir)[1];
          }

          victim animmode("\xceW{\x1bX\x16\xbc}\x87\xdd\xbd\xa4\x17\xe8\xbb");
        }

        if(trace["<dev string:x61>"] < 1 && getdvarint(@ "hash_26c518dff1e97f80", 0)) {
          sphere(tracestart, 3, (0, 0, 1), 1, 750);
        }
      }
    }

    if(isDefined(anim_name)) {
      if(istrue(victim.var_cfd60bad5e727a88)) {
        animinfostop = animbank::function_fe721d46c085d273("}\x01~\xb6\x118\xe7VK2*E\xc9\x10f,\x14\x1a\xc8\xb7W~\xe0\r\xc1\xf3\x15\xf1\x1f\xa4\x06\xaf", victim.var_f70e23be8eea93e5);
        assert(isDefined(animinfostop));
        animassetstop = animinfostop[0];
        blendtimestop = 0.2;
        victim setanim(animassetstop, 0, blendtimestop);
      }

      if(isDefined(victim_orient)) {
        victim orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", victim_orient);
      }

      if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
        iprintlnbold("<dev string:x6d>" + anim_name);
      }

      animinfo = animbank::function_fe721d46c085d273("}\x01~\xb6\x118\xe7VK2*E\xc9\x10f,\x14\x1a\xc8\xb7W~\xe0\r\xc1\xf3\x15\xf1\x1f\xa4\x06\xaf", anim_name);
      animasset = animinfo[0];
      blendtime = animinfo[1];
      assert(isDefined(animasset));
      victim setanim(animasset, 1, blendtime, 1);
      victim setanimtime(animasset, 0);
      animlength = getanimlength(animasset);
      eventtimes = getnotetracktimes(animasset, "-\x86\xab92zu'.W||N\xa2\xf4");
      explodedelay = animlength;

      if(isDefined(eventtimes[0])) {
        explodedelay = min(eventtimes[0] * animlength, 1);
      }

      victim utility::waittill_notify_or_timeout("*nb/P\aO\x12Q\xee\x10Qw\xf6\xc4!\xea\xc4\xe5\xb7\xbb<\xae\x90\x93\xcf!", explodedelay);
      victim body_shield_grenade_explode(player);
      break;
    }
  }
}

function private function_8e00609a1b57f98c() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.allowpain = 0;
  self.ignoreme = 1;
  self.var_34a1ace987b363bb = 1;

  if(self isragdoll()) {
    return;
  }

  self stopanimScripted();
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.var_a708ed7f30b53c0b);
  self animmode("\x1b\x9e\x86\xecr\x97\xa2");
  animinfo = animbank::function_fe721d46c085d273("}\x01~\xb6\x118\xe7VK2*E\xc9\x10f,\x14\x1a\xc8\xb7W~\xe0\r\xc1\xf3\x15\xf1\x1f\xa4\x06\xaf", "Q\xf9\x85\xdb\xe2xs\xc7IgB\xab");
  animasset = animinfo[0];
  blendtime = animinfo[1];
  assert(isDefined(animasset));
  self setanim(animasset, 1, blendtime);
  self setanimtime(animasset, 0);
  wait getanimlength(animasset);
  self.allowpain = 1;
  self.ignoreme = 0;
  self.var_84e29d1c0c629cbf = undefined;
  self.var_34a1ace987b363bb = undefined;
}

function private function_fd364d97c667c044() {
  player = level.player;
  victim = player.takedown.body_shield.victimai;
  victim endon("\x9c\xdf&U\xb9%!h\x11S\xd7\xbfB\x89\xd8\f\xed>\xfb\xdas\xe1\xdb\x874P\xf0t\xcb>\xd3\xab\x9b]\x81\x95");
  victim endon("\x1e\xfd\xd1\xa2\a");
  animinfo = animbank::function_fe721d46c085d273("}\x01~\xb6\x118\xe7VK2*E\xc9\x10f,\x14\x1a\xc8\xb7W~\xe0\r\xc1\xf3\x15\xf1\x1f\xa4\x06\xaf", victim.var_f70e23be8eea93e5);
  animasset = animinfo[0];
  blendtime = animinfo[1];
  assert(isDefined(animasset));
  explodedelay = 2;

  if(!istrue(victim.var_fe00a0ed17a6575d)) {
    victim.var_cfd60bad5e727a88 = 1;
    victim setflaggedanimrestart("B<\xbb:\xa1?m_\x13\xdbG", animasset, 1, blendtime);
    victim setanimtime(animasset, 0);
    animlength = getanimlength(animasset);
    eventtimes = getnotetracktimes(animasset, "-\x86\xab92zu'.W||N\xa2\xf4");
    explodedelay = animlength;

    if(isDefined(eventtimes[0])) {
      explodedelay = min(eventtimes[0] * animlength, explodedelay);
    }
  }

  victim utility::waittill_notify_or_timeout("*nb/P\aO\x12Q\xee\x10Qw\xf6\xc4!\xea\xc4\xe5\xb7\xbb<\xae\x90\x93\xcf!", explodedelay);
  victim body_shield_grenade_explode(player);
}

function private body_shield_grenade_explode(player) {
  victim = self;

  if(isDefined(victim)) {
    victim detach("\x8fY\xd0\x95B@7\xb4#<\x9cC\xe6\xea\b\xe9\x055\xc8\xc7|\xd3\xeb\xe0\x98:\x8e\x1d\xdd", "s\xbc|\xb0\xec\xbe\xe6\x7f\xff\x84\xb0\x82R\xae\x8e]xC");
    victim val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");
    player.takedown.body_shield.grenade_origin = victim gettagorigin("s\xbc|\xb0\xec\xbe\xe6\x7f\xff\x84\xb0\x82R\xae\x8e]xC");
    grenadeweapon = makeweapon("\x11\xc8#\xc06\xbbwW\x9c\x9d\xacp\xab\x91\xe19\xd8\xf83");
    magicgrenademanual(grenadeweapon, player.takedown.body_shield.grenade_origin, (0, 0, 0), 0, player);
    snd::play("QN\xa6\xb9\xf1\x83\xebZ*\x91>JS<\x05\x0fAI\xf3.-\xea\x9d\x1c+\xae;\x18\xff", player.takedown.body_shield.grenade_origin);
    player.takedown.body_shield.body delete();
    player.takedown.body_shield.body = undefined;
    victim notify("\x9c\xdf&U\xb9%!h\x11S\xd7\xbfB\x89\xd8\f\xed>\xfb\xdas\xe1\xdb\x874P\xf0t\xcb>\xd3\xab\x9b]\x81\x95");
  }
}

function private function_dcb97ecc37fcc60d(var_e0072cdfd47e79b0 = 0.5) {
  player = self;
  forward = anglesToForward(player.angles);
  start = player getorigin();
  start = (start[0], start[1], start[2] + 5);
  height = player getvieworigin()[2] - start[2];

  if(height * 0.5 < 8) {
    height = 16;
  }

  end = start + forward * 80;
  forward_trace = trace::capsule_trace(start, end, 8, height, undefined, [player], level.body_shield.collisioncontents);

  if(forward_trace["\xda\x16\x81\aw}^i"] < 1) {
    if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
      trace::draw_trace(forward_trace, (1, 0, 0), 1, 1);
      iprintln("<dev string:x80>" + abs(forward_trace["<dev string:x57>"][2]));
    }

    return false;
  }

  end_down = (end[0], end[1], end[2] - 25);
  down_trace = trace::ray_trace(end, end_down, [player], level.body_shield.var_baaf51519bdfbe6f, 0, 1);

  if(down_trace["\xda\x16\x81\aw}^i"] < 1) {
    if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
      trace::draw_trace(down_trace, (0, 1, 0), 1, 1);
      dist_down = abs(down_trace["<dev string:x95>"][2] - start[2] - 5);
      iprintln("<dev string:xa1>" + dist_down + "<dev string:xba>" + (dist_down <= 20));
    }

    return (abs(down_trace["+0a<s,"][2]) > var_e0072cdfd47e79b0);
  }

  if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
    iprintln("<dev string:xc6>");
  }

  return false;
}

function private body_shield_playermonitorprompts() {
  player = self;
  player notify("\x98\xf6\xc8\x97_nhZ\xb2l2}\xe0\x1b,\xbc+\xc95\xedsiGo'\xa0'om\x1c\xe8s");
  player endon("\x98\xf6\xc8\x97_nhZ\xb2l2}\xe0\x1b,\xbc+\xc95\xedsiGo'\xa0'om\x1c\xe8s");
  player endon("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  var_8cb95b0dfa90b063 = 40;

  while(true) {
    displaydrop = 1;

    if(player isparachuting() || player isskydiving() || !player isonground() || player isonladder() || player isjumping() || player isonascender() || player isswimming() || istrue(level.missionfailed)) {
      displaydrop = 0;
    }

    if(istrue(displaydrop)) {
      if(!player input_prompts::function_b9f10eee2e26e566("\x91\xca\xcc\v\xab\xd8:", "\x8e\f\xe4I")) {
        player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", "\x8e\f\xe4I", &"hash_7f5a21eb2c7f175");
        player notifyonplayercommand("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "\xe88-\x97\xb82a");
        player notifyonplayercommand("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "z\xf5\xbaH \x13\xbeo\x87");
        player notifyonplayercommand("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "b\x06\xaa`]\xbc\xf5>\xa5\xb5\xff*p");
      }
    } else {
      player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "\x8e\f\xe4I");
      player notifyonplayercommandremove("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "\xe88-\x97\xb82a");
      player notifyonplayercommandremove("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "z\xf5\xbaH \x13\xbeo\x87");
      player notifyonplayercommandremove("\xce\xc8\xbc}1\xdd\x80/u\xfc\x7fAa\x14\t\xdf\xf4\x98", "b\x06\xaa`]\xbc\xf5>\xa5\xb5\xff*p");
    }

    var_8ed57abc1e9f9890 = player function_dcb97ecc37fcc60d();
    var_49431cd1478801f = isDefined(player.takedown.body_shield.victimai) && player.takedown.body_shield.victimai utility::ent_flag("\xdd\xef\x0e\xf4RaE\x01\xd5>9q)\xaae\xe7M\n\x94\xc3X{\xfe\x17\x99S\xbd\xd3\xe3\x9f\x16\x19\xe0E\x15");
    var_d50458c93462fe91 = !istrue(displaydrop) || !(isDefined(player.takedown.body_shield) && isDefined(player.takedown.body_shield.victimai)) || var_49431cd1478801f || !var_8ed57abc1e9f9890;

    if(!var_d50458c93462fe91) {
      forward = anglesToForward(player getplayerangles(1));
      check_origin = player.origin + forward * var_8cb95b0dfa90b063;
      check_origin = (check_origin[0], check_origin[1], check_origin[2] + 15);
      actors = getaiarrayinradius(check_origin, var_8cb95b0dfa90b063);

      if(getdvarint(@ "hash_26c518dff1e97f80", 0)) {
        sphere(check_origin, var_8cb95b0dfa90b063, (1, 1, 1), 1, 1);
      }

      foreach(guy in actors) {
        if(isai(guy) && guy != player.takedown.body_shield.victimai) {
          var_d50458c93462fe91 = 1;
          break;
        }
      }
    }

    if(var_d50458c93462fe91) {
      if(player input_prompts::function_b9f10eee2e26e566("\x91\xca\xcc\v\xab\xd8:", ",\xe1\x93So\x98\r")) {
        player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", ",\xe1\x93So\x98\r");
        player notifyonplayercommandremove("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "n-\xa2\xff\xb9");
      }
    } else if(!player input_prompts::function_b9f10eee2e26e566("\x91\xca\xcc\v\xab\xd8:", ",\xe1\x93So\x98\r")) {
      player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", ",\xe1\x93So\x98\r", &"hash_2b1a10e1ed0d1c00");
      player notifyonplayercommand("\xcb}\x9d&\x99\xdb\x91D\xf8!6'\xb9h\x98\xc1\x84", "n-\xa2\xff\xb9");
    }

    waitframe();
  }
}

function function_8a8ad5a17f78712f(victim) {
  assert(isPlayer(self));

  if(!utility::ent_flag("\xf6\xf5\x163\x9b\xf2(\xfdY\xd8E\x95\x01\x99\x05\xb5\x97\xc3\x1f\x05\xe2\xc1\xf8\x18y\x80]\x80e")) {
    self.takedown.body_shield.var_465d9063611f1221 = 1;
    createnavrepulsor("\xee\xf4\x96Gg\xd6\x86`\x8c\xd5\x86", 0, victim, 215, 1, "?\xb1\xc0\x9a");
  }

  level.player setsoundsubmix("n8}\xa3\xc4\x03_b\xdb#\xe5n\x1a-+\x1bF\xf5\xc8\xear\xb0\xe8\xd2\xed\x9b");
  val::reset_all("/\x1f\xc7\x96\xfc\xc8\x12P<k\x8b\xb7p\x1b\xdbo");
  thread player_sp::regeneratehealth();
  self.takedown.scene_root = undefined;
  childthread function_7771c4233da14a();
  disabledrain = undefined;

  if(getdvarint(@ "hash_a37e44bb012e874f", 0)) {
    disabledrain = 1;
  }

  if(!istrue(disabledrain)) {
    childthread function_6370e7bfc34da060();
  }

  childthread body_shield_playermonitorprompts();
}

function private function_b392b96c5a3258c6(in_bodyshield) {
  assert(isai(self));
  utility::ent_flag_clear("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");

  if(istrue(in_bodyshield)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
    self notsolid();
    self clearenemy();
    self setgoalpos(self.origin);
    self animcustom(&function_4552e68aaf90c5a1);
    self.in_bodyshield = 1;
    return;
  }

  self.ignoreme = 0;
  utility::delaycall(level.frameduration, &solid);
  self setgoalpos(self.origin);
  self.in_bodyshield = undefined;
}

function private function_8ae618d985ce9faf(fullbody, clearanims, linktype) {
  assert(isPlayer(self));
}

function private function_f6a4be07804d397c(fullbody, player_arms, clearanims, linktype) {
  assert(isPlayer(self));
  function_8ae618d985ce9faf(fullbody, clearanims, linktype);

  if(!isDefined(player_arms)) {
    player_arms = self.var_19c857753a6afe3a;
  }

  if(isDefined(player_arms)) {
    player_arms show();
  }
}

function private function_a24107b50ff1e08d(player_arms) {
  assert(isPlayer(self));

  if(!isDefined(player_arms)) {
    player_arms = self.var_19c857753a6afe3a;
  }

  if(isDefined(player_arms)) {
    player_arms hide();
    player_arms function_ec1f49dad67915f();
  }
}

function private function_4552e68aaf90c5a1() {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
  self waittill("e\x14\x16\xc5\xc8");
}

function private function_6fbb59bad2d660d5(animnameplay, blendtime, clearanims) {
  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  if(!isDefined(clearanims)) {
    clearanims = 1;
  }

  function_ec1f49dad67915f(blendtime, clearanims);
  self endon("\x1e\xfd\xd1\xa2\a", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19", "\xba\x94u\x7f0C\xd11\xb2\xe1\xd84\xe1]|M\xcc\x9c");
  animplay = undefined;
  assert(isDefined(animplay));
  self clearanim(animplay, 0);
  self setanim(animplay, 1, blendtime, 1);
  self.var_6fbb59bad2d660d5 = animplay;
  wait getanimlength(animplay);
  self.var_6fbb59bad2d660d5 = undefined;

  if(clearanims) {
    self clearanim(animplay, blendtime);
  }
}

function private function_a5253de3ae18f271(animloopname, blendtime) {
  if(isDefined(self.var_a5253de3ae18f271) && self.var_a5253de3ae18f271 == level.player_actions.anims[self.animname][animloopname]) {
    return;
  }

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  function_ec1f49dad67915f(blendtime);
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\xba\x94u\x7f0C\xd11\xb2\xe1\xd84\xe1]|M\xcc\x9c");
  animloop = undefined;
  self clearanim(animloop, 0);
  self setanim(animloop, 1, blendtime, 1);
  self.var_a5253de3ae18f271 = animloop;

  while(isDefined(animloop)) {
    self setanimtime(animloop, 0);
    animlength = getanimlength(animloop);
    wait animlength;
  }
}

function private function_ec1f49dad67915f(blendtime, clearanims) {
  self notify("\xba\x94u\x7f0C\xd11\xb2\xe1\xd84\xe1]|M\xcc\x9c");
  self notify("\xf6\xf6Q\xad\xf7\xb07\x96\xf6\x98y:\xd0\xf6\xcf\x98$");

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  if(!isDefined(clearanims)) {
    clearanims = 1;
  }

  if(isDefined(self.var_a5253de3ae18f271)) {
    if(clearanims) {
      self clearanim(self.var_a5253de3ae18f271, blendtime);
    }

    self.var_a5253de3ae18f271 = undefined;
  }

  if(isDefined(self.var_6fbb59bad2d660d5)) {
    if(clearanims) {
      self clearanim(self.var_6fbb59bad2d660d5, blendtime);
    }

    self.var_6fbb59bad2d660d5 = undefined;
  }
}

function function_293d1c40fe616b61() {
  function_71aa09612cd50469("\xd9\xcas\xd7\x98\xf6#\xe5\xafsCK\x95\xc6\x8c\xfa9\xa5f\xc6e");
  function_71aa09612cd50469("\xdeg\xac\x8c\x151\xa8D2W\xc7\xcey\xd0\x82p\x1d\x8b\xa3\xcb\xa2>g\x8f\x86");
  function_71aa09612cd50469("p\xaa3\xf1\xd6\xa3K%\xb0\xa3\x10\xf3\x93\t\xeb\x1e\xa5\xc0G(pPV");
  self notify("\x05\xd4\xb1fs>R\xcc\xbf\x1d\xbe\xef{\xa4\xd9\x9eO\n\xdf\xd9#R\x01?\x9e\tC\xea\x06\xfdw*o");
}

function function_71aa09612cd50469(gesture) {
  if(isDefined(self.takedown.gesture_hold) && self.takedown.gesture_hold == gesture) {
    self.takedown.gesture_hold = undefined;
    return;
  }

  carrylinked::gesture_stop(gesture, 0.01, 1);
}

function function_7771c4233da14a() {
  self endon("\xd3E6\xae{\x14\x19c{\x11:y\xac\xfbC\xf9");
  self waittill("\x1e\xfd\xd1\xa2\a", var_c870d6e855671109);

  if(isDefined(self.takedown.body)) {
    self.takedown.body hide();
  }

  carrylinked::end();
}

function function_46ad6492586dbfa() {
  assert(isPlayer(self));

  if(isDefined(self.takedown.body_shield) && isDefined(self.takedown.body_shield.actor)) {
    self.takedown.body_shield.actor delete();
    self.takedown.body_shield.actor = undefined;
  }
}

function function_2a12b3a54138bfe1() {
  assert(isPlayer(self));

  if(!isDefined(self.takedown.body_shield.actor)) {
    return;
  }

  if(!val::get("#\xb1\xbb\x16\xb8\xbd\xbe\xcd\xder\x1d\x12\x16\xd6\x99-\x93x")) {
    return;
  }

  self.takedown.body_shield.actor delete();
  self waittill("l\xbf\x14~SV\"\tp\xd6\xe4\xe2RF\x851\xdc\xd0*j");
}

function function_61642a94145cde6e() {}

function function_4048fc75f74db741() {
  waittime = randomfloatrange(0.2, 0.6);
  wait waittime;
}

function private function_c9bcf0b09e49206b(percent, time) {
  assert(isPlayer(self));
  player = self;
  refname = "^!;)\xb2a\xea\xa8is)!\xe5*{X\xf9\x89";
  isactive = player hud_management::function_48c98ea9a4f0da89(refname);
  fields = [];

  if(!isactive) {
    widget = hud_management::function_a1a13273e72bfe46("\x0e\x89s\xa2]U2A\xdd\b\xae\xbf\xf6\x11\x87(\x96\xb05\x06\xe5\xbd&\xc8\xc1<W");
    player hud_management::function_35924dfcb78711f4(refname, widget);
    player hud_management::function_85d8a0ba2e35b6f2(refname, 0, 130, 1, 1);
    fields["\x80O\xea\xdb[j\x9b\xd0O\xb6#"] = clamp(percent, 0, 1);
  } else {
    fields = player hud_management::function_594f6081e9662d1a(refname);
    fields["\x80O\xea\xdb[j\x9b\xd0O\xb6#"] = max(percent, fields["P\xf6fx\xd7\b\x01\xecu\x9d"]);
  }

  fields["\x92\xd3\x9f\xbb"] = time;
  fields["P\xf6fx\xd7\b\x01\xecu\x9d"] = clamp(percent, 0, 1);
  player hud_management::function_41ff479ac45608d6(refname, fields);

  if(percent < 0.25) {
    player hud_management::function_d8d634ceece460(refname, "\x13\xeci\x88tl");
    return;
  }

  player hud_management::function_d8d634ceece460(refname, "\x11\xca\xcc\v\xab\xd8:");
}
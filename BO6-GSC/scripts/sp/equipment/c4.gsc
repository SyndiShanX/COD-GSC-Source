/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\c4.gsc
***************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\damagefeedback;
#using scripts\sp\door;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#namespace c4;

function private autoexec initc4() {
  offhands::registerprecachefunc("O\n\x881A", &precache);
}

function precache(offhand) {
  offhands::registeroffhandfirefunc(offhand, &c4firemain);
}

function c4firemain(grenade, weapon, ignorestuck) {
  if(!isDefined(grenade)) {
    return;
  }

  grenade endon("\x1e\xfd\xd1\xa2\a");
  grenade.owner = self;
  grenade setentityowner(self);
  grenade setotherent(self);
  grenade makeunusable();
  grenade.targetname = "\x7f\x9dRc\x83\xca\xc9\xea$8!d1\x1d\xe0\xf57\xd4\x14";
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.throwtime = gettime();
  c4_addtoarray(self, grenade);

  if(isDefined(level.var_7d786abdb400836c)) {
    self thread[[level.var_7d786abdb400836c]](grenade);
  } else {
    thread c4_watchfordetonation(grenade);
  }

  grenade thread minedamagemonitor();
  grenade thread c4_explodeonnotify();

  if(!istrue(ignorestuck)) {
    grenade waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto, tag);

    if(isent(stuckto) && !istrue(stuckto.var_60cdd7b39f24a564)) {
      linked = 0;

      if(isDefined(tag) && tag != "\xec\xbfK|\au\xcd\xc2\x19<") {
        tagorigin = stuckto gettagorigin(tag, 1, 0, 0);
        tagangles = stuckto gettagangles(tag, 1, 0, 0);

        if(isDefined(tagorigin) && isDefined(tagangles)) {
          localtagorigin = coordtransformtranspose(grenade.origin, tagorigin, tagangles);
          localtagangles = combineanglesinverted(tagangles, grenade.angles);
          grenade linkTo(stuckto, tag, localtagorigin, localtagangles);
          linked = 1;
        }
      }

      if(!linked) {
        grenade linkTo(stuckto);
      }
    }
  }

  thread offhands::function_1ddd67f9826838b(grenade, weapon, &"equipment/improvised_mine_pickup", "\xcd\xe5\x01&\xbeXl\xa2\x90\x8d\x16r\xa3\x9e\xee\x9f\xa3");
  grenade setscriptablepartstate("\xfd^\xd8J\x03\b\x1b", "~xGEv", 0);
  grenade thread utility::navrepulsorremoveondeath(256, "O\x15\x1b\xad\x9ff", 20);
}

function c4_watchfordetonation(grenade) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x8c\xc2\x8f~\xb1<&\xad");
  self notify("}\x1eG\x05\x14\xb1\xc07\xb4!\x8f\x17\x98\xa6-\xd3V>");
  self endon("}\x1eG\x05\x14\xb1\xc07\xb4!\x8f\x17\x98\xa6-\xd3V>");
  childthread function_87bd6af142dd1390(grenade);

  while(true) {
    self waittill("#\xacG\xb7\xcd\vt\xac");
    thread c4_detonateall();
  }
}

function function_87bd6af142dd1390(grenade) {
  self endon("#\xacG\xb7\xcd\vt\xac");
  grenade endon("\x1e\xfd\xd1\xa2\a");
  var_77d6dbf79e3f455d = ":\x8dYuZ$\xf8\x8b^<(";
  detonatedelay = 0.5;

  while(true) {
    self waittill(var_77d6dbf79e3f455d);

    if(!val::get("54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w")) {
      continue;
    }

    if(utility_sp::player_has_equipment(grenade)) {
      continue;
    }

    result = utility::waittill_notify_or_timeout_return(var_77d6dbf79e3f455d, 1);

    if(result != var_77d6dbf79e3f455d) {
      continue;
    }

    wait detonatedelay;
    self notify("#\xacG\xb7\xcd\vt\xac");
  }
}

function c4_watchforaltdetonation() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8c\xc2\x8f~\xb1<&\xad");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(!getdvarint(@ "scr_altdetonationenabled", 0)) {
    return;
  }

  self notify("\xe9\xc4;9\xa5\xc0\xd9eLH\xe1\xfe\xec\\\x1c\xbe\x8eg\xef\xfb\xde");
  self endon("\xe9\xc4;9\xa5\xc0\xd9eLH\xe1\xfe\xec\\\x1c\xbe\x8eg\xef\xfb\xde");

  while(self useButtonPressed()) {
    waitframe();
  }

  buttontime = 0;

  while(true) {
    if(self useButtonPressed()) {
      buttontime = 0;

      while(self useButtonPressed()) {
        buttontime += 0.05;
        waitframe();
      }

      if(buttontime >= 0.5) {
        continue;
      }

      buttontime = 0;

      while(!self useButtonPressed() && buttontime < 0.25) {
        buttontime += 0.05;
        waitframe();
      }

      if(buttontime >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
        thread c4_animdetonate();
      }
    }

    waitframe();
  }
}

function c4_animdetonate() {
  objweapon = makeweapon("6\x86\xd7\xb2\xb5\xc1:\xbc_\x9b8");
  self giveandfireoffhand(objweapon);
  thread c4_animdetonatecleanup();
}

function c4_animdetonatecleanup() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self notify("%\x8e\xd0\xd3\xd5\xeb>\x1c\xf90\xd1u\xda\xe8\x16=\xc8&\x81\xc6c)\x1dq");
  self endon("%\x8e\xd0\xd3\xd5\xeb>\x1c\xf90\xd1u\xda\xe8\x16=\xc8&\x81\xc6c)\x1dq");
  objweapon = makeweapon("6\x86\xd7\xb2\xb5\xc1:\xbc_\x9b8");
  wait 1;

  if(self hasweapon(objweapon)) {
    self takeweapon(objweapon);
  }
}

function c4_validdetonationstate() {
  if(!isalive(self)) {
    return false;
  }

  if(!isDefined(self.c4s) || self.c4s.size <= 0) {
    return false;
  }

  return true;
}

function c4_candetonate() {
  return (gettime() - self.throwtime) / 1000 > 0.3;
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(c4 in self.c4s) {
      if(c4 c4_candetonate()) {
        c4 thread c4_detonate();
      }
    }
  }
}

function c4_detonate() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  wait 0.1;
  thread c4_explode(self.owner);
}

function c4_explode(attacker) {
  if(!isent(self)) {
    return;
  }

  if(isent(attacker)) {
    self setentityowner(attacker);
  }

  self clearscriptabledamageowner();
  self setscriptablepartstate("\xfd^\xd8J\x03\b\x1b", "*\x83\xc10XI\x1e", 0);
  self notify("*\x83\xc10XI\x1e");
  addactivesmoke(self.origin + (0, 0, 30), 1.3, 150, 100);
  function_6eee08227777bf1();
  thread c4_delete(level.var_de5d12b418601955 ?? 2.5);
}

function c4_destroy(attacker) {
  thread c4_delete(2.5);
  self setscriptablepartstate("\xfd^\xd8J\x03\b\x1b", "\xe7\xe2ST\xee\xc0\xf6", 0);
}

function c4_delete(deletiondelay) {
  self notify("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.cursor_hint_ent)) {
    self.cursor_hint_ent notify("\x1e\xfd\xd1\xa2\a");
  }

  self setCanDamage(0);
  self makeunusable();
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(owner)) {
    c4_removefromarray(owner, self, self getentitynumber());
    owner notify("_-\x81\x83e\x1f\x8c9Y", 0);
  }

  wait deletiondelay;

  if(isDefined(self)) {
    self delete();
  }
}

function function_6eee08227777bf1() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_a51c586c9d4f3d8c)) {
    return;
  }

  interactivedoors = door_sp::get_all_interactive_doors();
  spherecasts = function_5ea0b3082fbedc06(self.origin, self.origin, 256, trace::create_item_contents(), interactivedoors, "\x03\xd8}k\x14\xbfh\xcb\xf3\xc4\xa3\x94@p\x84\xb0");

  foreach(spherecast in spherecasts) {
    door = spherecast["\x1f\xa8\x10WP\xa9"];
    opener = spawnStruct();
    opener.origin = self.origin;
    door notify("\x85\xb9jliEQ\xdd");
    door door_sp::unlock_door(1);
    door door_sp::door_open_completely(opener, 0.3);
  }
}

function c4_explodeonnotify() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  owner = self.owner;
  self waittill("\xf4\xae\x96_d\xc2\x95\xc6\x0e\xc0Q\x80\x8f\xe0\xcfej", attacker);

  if(isDefined(attacker)) {
    thread c4_explode(attacker);
    return;
  }

  thread c4_explode(owner);
}

function c4_addtoarray(owner, grenade) {
  if(!isDefined(owner.c4s)) {
    owner.c4s = [];
  }

  entnum = grenade getentitynumber();
  owner.c4s[entnum] = grenade;

  if(isPlayer(owner)) {
    owner function_54c0003a7284c52f(1);
  }

  oldest = -1;

  while(owner.c4s.size > 10 && !isDefined(owner.c4s[oldest])) {
    oldest = getfirstarraykey(owner.c4s);

    if(!isent(owner.c4s[oldest])) {
      owner.c4s[oldest] = undefined;
    }
  }

  if(isent(owner.c4s[oldest])) {
    owner.c4s[oldest] thread c4_delete(2.5);
  }

  thread c4_removefromarrayondeath(owner, grenade, entnum);
}

function c4_removefromarray(owner, grenade, entnum) {
  if(isDefined(grenade)) {
    grenade notify("\x8d\x86\xbe\x9c\xb2\xad\xed\xb3\xacF\xe4\xde[\x05N\xc9\xb0\xbc");
  }

  if(isDefined(owner) && isDefined(owner.c4s) && isPlayer(owner)) {
    owner.c4s[entnum] = undefined;

    foreach(c4 in owner.c4s) {
      if(isDefined(c4)) {
        return;
      }
    }

    owner function_54c0003a7284c52f(0);
  }
}

function c4_removefromarrayondeath(owner, grenade, entnum) {
  grenade endon("\x8d\x86\xbe\x9c\xb2\xad\xed\xb3\xacF\xe4\xde[\x05N\xc9\xb0\xbc");
  owner endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(isent(grenade)) {
    grenade waittill("\x1e\xfd\xd1\xa2\a");

    if(!isent(grenade)) {
      thread c4_removefromarray(owner, grenade, entnum);
    }
  }
}

function c4nodetonatorfiremain(c4) {
  if(!isDefined(c4)) {
    return;
  }

  level.player endon("\x1e\xfd\xd1\xa2\a");
  c4 waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto);
  c4.targetname = "\xa0\x12\x86Jp\x85A\xf8 n\xe12\x18\x05\xb6\xc0\xb0\x99\xe2\xe8\\\xbaq";
  c4.owner = self;
  c4 setscriptablepartstate("\xfd^\xd8J\x03\b\x1b", "~xGEv", 0);
  c4 makeunusable();
  c4.interact = c4 c4createcursor();
  result = utility::waittill_any_ents_return(c4, "#\xacG\xb7\xcd\vt\xac", c4.interact, "\x91`\xb1\xe7T\x97>", c4.interact, "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(c4.interact)) {
    c4.interact delete();
  }

  if(result == "#\xacG\xb7\xcd\vt\xac") {
    c4 thread c4detonation();
    return;
  }

  if(result == "\x91`\xb1\xe7T\x97>") {
    c4 delete();
    thread utility::play_sound_in_space("\xddV,\xe0}\a-lk\xae\a", level.player.origin);

    if(level.player utility_sp::player_has_weapon("N\x97\x14\x8c\x84\x147M\xc5!2\xf4\\\x12\x1b")) {
      ammostock = level.player getweaponammostock("N\x97\x14\x8c\x84\x147M\xc5!2\xf4\\\x12\x1b");
      level.player setweaponammoclip("N\x97\x14\x8c\x84\x147M\xc5!2\xf4\\\x12\x1b", ammostock + 1);
      return;
    }

    level.player utility_sp::give_offhand("N\x97\x14\x8c\x84\x147M\xc5!2\xf4\\\x12\x1b");
    level.player setweaponammoclip("N\x97\x14\x8c\x84\x147M\xc5!2\xf4\\\x12\x1b", 1);
  }
}

function c4detonation() {
  self setscriptablepartstate("\xfd^\xd8J\x03\b\x1b", "*\x83\xc10XI\x1e", 0);
}

function c4createcursor() {
  interact = utility::spawn_tag_origin();
  interact linkTo(self);
  interact cursor_hint::create_cursor_hint("\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 10), "\x97\x91\x82-\xd8\xadW\x0e", 35, 250, 100, 0, undefined, undefined, undefined, "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96", undefined, undefined, 8);
  return interact;
}

function minedamagemonitor() {
  self endon("\xdf?\x83\xa6\x1e\xd8\xf8\xde&\xc9?\x1d\x1e;\xb8\t\xa1");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  hits = 1;

  while(true) {
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(self === inflictor) {
      continue;
    }

    if(!isPlayer(attacker) && !isagent(attacker) && !istrue(self.ignoreattackers)) {
      continue;
    }

    if(isDefined(objweapon) && objweapon.basenamehash == % "flash") {
      continue;
    }

    if(type == "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
      continue;
    }

    if(isPlayer(attacker)) {
      attacker damagefeedback::updatehitmarker("7\xfd\x90\xc0\b\xb3L\xe5", 1, 0);
    }

    incominghits = 1;
    hits -= incominghits;

    if(hits <= 0) {
      break;
    }
  }

  self notify("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");

  if(isDefined(type) && (issubstr(type, "\x9az\x88\xfat)*\xe4\x14\x11\x15") || issubstr(type, "\xa2rl\xdaDn\x17b\xd9I\xc9=N"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && isDefined(8) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(idflags) && isDefined(256) && idflags & 256) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(attacker)) {
    self.damagedby = attacker;
  }

  waitframe();
  self notify("\xf4\xae\x96_d\xc2\x95\xc6\x0e\xc0Q\x80\x8f\xe0\xcfej", attacker);
}

function function_4e862bb907663c80(c4, var_44c4853677444462) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("#\xacG\xb7\xcd\vt\xac");

  while(true) {
    c4 cursor_hint::create_cursor_hint(undefined, (0, 0, 5), &"equipment/improvised_mine_pickup", 55, 100, 70, 0);
    c4 childthread offhands::function_5a3d8556cf563b1c(&"equipment/improvised_mine_pickup", var_44c4853677444462);
    c4 waittill("\x91`\xb1\xe7T\x97>");
    pickedup = offhands::function_55036eabed198cc9(var_44c4853677444462);

    if(!pickedup) {
      continue;
    }

    c4 delete();
    return;
  }
}
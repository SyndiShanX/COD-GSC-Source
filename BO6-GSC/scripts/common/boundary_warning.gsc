/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\boundary_warning.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace boundary_warning;

function private autoexec __init__system__() {
  system::register(#"boundary_warning", undefined, undefined, &post_main);
}

function private post_main() {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!isDefined(level.var_d98f833325a6a1f)) {
    level.var_d98f833325a6a1f = spawnStruct();
  }

  level.var_d98f833325a6a1f = hud_management::function_a1a13273e72bfe46("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
  level.boundary_triggers = [];

  foreach(player in level.players) {
    player thread function_841a3ca21885ea7();
    player thread function_3ea129d9414645ec();
  }

  triggers = getEntArray("\t6\xc6\xf8\xac<w+\xbd\xc21\x7f\xfc\x05\xe7G\xd8\x01\xf5\xf2\xf5", #targetname);

  if(isDefined(triggers) && triggers.size) {
    level add_triggers(triggers);
  }

  utility::callsharedfunc(#"aggregator", #"registeronplayerspawncallback", &function_11790bc3eca16f2b);
}

function private function_11790bc3eca16f2b() {
  thread function_841a3ca21885ea7();
  thread function_3ea129d9414645ec();
}

function private function_3ea129d9414645ec() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    self waittill("#\x03q\xe2\xec\xfd\r\x1a*q\x91\xadw1O:7g\xb2\xc3/", is_allowed);

    if(is_allowed && isDefined(self.var_79e0e45993608434) && self.var_79e0e45993608434.size > 0) {
      function_b0f305775a64431e();
    }
  }
}

function add_triggers(oob_triggers) {
  if(isDefined(oob_triggers)) {
    if(!isarray(oob_triggers)) {
      level add_trigger(oob_triggers);
      return;
    }

    foreach(trigger in oob_triggers) {
      level add_trigger(trigger);
    }
  }
}

function function_d2081642360674e9(oob_triggers) {
  if(isDefined(oob_triggers) && oob_triggers.size) {
    if(!isarray(oob_triggers)) {
      level kill_trigger(oob_triggers);
      return;
    }

    foreach(trigger in oob_triggers) {
      level kill_trigger(trigger);
    }
  }
}

function function_aba3a119af8c2f64() {
  if(level.boundary_triggers.size) {
    foreach(trigger in level.boundary_triggers) {
      trigger delete();
    }

    foreach(player in level.players) {
      player.var_79e0e45993608434 = undefined;
    }

    level.boundary_triggers = undefined;
  }

  player function_971629b6731cc833();
}

function private add_trigger(trigger) {
  trigger_entnum = trigger getentitynumber();

  if(!isDefined(level.boundary_triggers[trigger_entnum])) {
    level.boundary_triggers[trigger_entnum] = trigger;
    trigger thread function_63f3552806a6db66();
  }
}

function private kill_trigger(trigger) {
  trigger_entnum = trigger getentitynumber();

  if(isDefined(level.boundary_triggers[trigger_entnum])) {
    level.boundary_triggers[trigger_entnum] = undefined;
  }

  foreach(player in level.players) {
    if(isDefined(player.var_79e0e45993608434[trigger_entnum])) {
      player.var_79e0e45993608434[trigger_entnum] = undefined;

      if(player.var_79e0e45993608434.size == 0) {
        player utility::flag_clear("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
      }
    }
  }

  trigger delete();
}

function private function_63f3552806a6db66() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self.fail_trigger = getEnt(self.target, #targetname);
  var_2bf547b1f820ef40 = self.spawnflags & 16;
  trigger_entnum = self getentitynumber();

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", ent);
    player_ent = undefined;

    if(isPlayer(ent)) {
      player_ent = ent;
    } else if(var_2bf547b1f820ef40 && isDefined(ent.driver) && isPlayer(ent.driver)) {
      player_ent = ent.driver;
    }

    if(isDefined(player_ent)) {
      if(!isDefined(player_ent.var_79e0e45993608434[trigger_entnum])) {
        player_ent.var_79e0e45993608434[trigger_entnum] = self;
        player_ent thread function_de58ddc06fc15ab3(self, trigger_entnum);
      }
    }
  }
}

function private function_de58ddc06fc15ab3(trigger, trigger_entnum) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  trigger endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  childthread function_e80dbd3bcbc03a86(trigger.fail_trigger);

  if(self.var_79e0e45993608434.size == 1) {
    self notify("W88\x14\xe9\xbc<B\xa0\x01}\xa5\f\xd8p3!");
    utility::flag_set("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
    callback::callback(#"hash_ab4420b2e1d75843", {
      #player: self
    });
  }

  while(self istouching(trigger)) {
    waitframe();
  }

  self notify("xF\x1c\xa8.A\xb6\x10'\x98tg\xc3\xa2\xb1");
  self.var_79e0e45993608434[trigger_entnum] = undefined;

  if(self.var_79e0e45993608434.size == 0) {
    thread function_d3af9ed480a93bc1();
  }
}

function private function_e80dbd3bcbc03a86(trigger) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("xF\x1c\xa8.A\xb6\x10'\x98tg\xc3\xa2\xb1");
  trigger waittill("\x91`\xb1\xe7T\x97>");
  self notify("\xdb,k\x9d\xearzc\x7fqU\x98\xf9\t8\xff");
  utility::callsharedfunc(#"oob", #"hash_4fb0dbfb79809bfd");
}

function private function_841a3ca21885ea7() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    utility::flag_wait("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
    function_b0f305775a64431e();
    utility::flag_waitopen("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
    function_971629b6731cc833();
  }
}

function private function_d3af9ed480a93bc1() {
  self endon("W88\x14\xe9\xbc<B\xa0\x01}\xa5\f\xd8p3!");
  wait 2;
  utility::flag_clear("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
}

function private function_b0f305775a64431e() {
  if(!val::get("#\x03q\xe2\xec\xfd\r\x1a*q\x91\xadw1O:7g\xb2\xc3/")) {
    return;
  }

  val::set("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "\xb4\xf8\xd7\x7fGm\xe7<\xf4N\x95}\x1fZ\xe5\xcfy\xc6", 1);
  var_731b52fa27728c91 = undefined;

  if(isDefined(level.var_d98f833325a6a1f)) {
    if(hud_management::function_48c98ea9a4f0da89("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d")) {
      hud_management::scripted_widget_destroy("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
    }

    hud_management::function_35924dfcb78711f4("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", level.var_d98f833325a6a1f);
    hud_management::function_85d8a0ba2e35b6f2("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", 0, -190, 1, 1);
    hud_management::function_b683400f784cb7dc("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "J+t\xd5\xc9s*{5Z\x9b\xcd-o\xcd");
    level.var_36cf133a29bf502f = hud_management::function_f7788e5b5434e49e(level.var_d98f833325a6a1f, "J+t\xd5\xc9s*{5Z\x9b\xcd-o\xcd", "\xe0\xde\xcd\xa3\xcc\xf0_&\xaen\x8c\xb1V\xbe9e\x99");

    if(isDefined(level.var_36cf133a29bf502f)) {
      object_name = strtok(level.var_36cf133a29bf502f, "\x93");

      if(isDefined(object_name) && isDefined(object_name[0])) {
        level.var_36cf133a29bf502f = object_name[0];
        pbgpostfxbundlestart(self, level.var_36cf133a29bf502f);
      }
    }

    fields = [];

    if(isDefined(var_731b52fa27728c91)) {
      fields["\xb5\xcd\xd9\xfaZ7FV\x1e"] = function_30e4f86dded0873(var_731b52fa27728c91);
    }

    fields["\xae\x90\xf8^}\x99\xe5p\xb8"] = 1;
    hud_management::function_41ff479ac45608d6("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", fields, 1);
  }
}

function private function_971629b6731cc833() {
  if(hud_management::function_48c98ea9a4f0da89("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d")) {
    hud_management::function_d8d634ceece460("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "\x19b\xc2y");

    if(isDefined(level.var_36cf133a29bf502f)) {
      pbgpostfxbundleend(self, level.var_36cf133a29bf502f);
      level.var_36cf133a29bf502f = undefined;
    }
  }

  val::reset_all("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
}
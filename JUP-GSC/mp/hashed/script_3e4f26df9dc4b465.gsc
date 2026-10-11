/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e4f26df9dc4b465.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_4fa22bc28608e9bd;
#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_cb396b2f1fa7bd07;

function function_3f12f7bb3b0f7b28() {
  function_fb0a160d277a9416();
}

function function_99484082dc3884de() {
  self.summon_cooldown = 0;
  self.var_52c29781bd641d26 = 0;
  self.var_cbb6735eca050540 = 0;
  self.var_90217cf570d78169 = 0;
  self.var_7f35bbdd17571a22 = self.zombieaisettings.var_e58a65b7a8f5973c.var_c8bcab8c1ce580a4;
  self.var_16874cb97aa71c9f = self.zombieaisettings.var_e58a65b7a8f5973c.var_15ca0d607bd0f65d;
  self.var_146b3cc414242deb = self.zombieaisettings.var_e58a65b7a8f5973c.var_6ad8008df08f66a8 * 1000;
  self.summon_invulnerability = self.zombieaisettings.var_e58a65b7a8f5973c.var_11513ec3b3dded73;
  self.var_7415a936b72426f1 = self.zombieaisettings.var_e58a65b7a8f5973c.var_49e28583f4085c3;
  self.var_446ffae9ade57ccc = self.zombieaisettings.var_e58a65b7a8f5973c.var_1edd3815011a08bd;
  self.var_68500b288d8cc059 = self.zombieaisettings.var_e58a65b7a8f5973c.enableheadicon;
  self.var_a021045e9363771b = self.zombieaisettings.var_e58a65b7a8f5973c.headiconmaxdistance;
  thread function_e8bb01e68081e922();
  self.var_8d3cf19b73a1a3d2 = self.zombieaisettings.var_e58a65b7a8f5973c.var_c366369faa4886e5;
  self.var_3c9f4a3679b898c6 = self.zombieaisettings.var_e58a65b7a8f5973c.var_e82fcf3a743fc4f8;
  self.var_78f6b2d381a73bf4 = 0;

  if(istrue(self.var_8d3cf19b73a1a3d2)) {
    thread function_e803d8fa2e7ce395();
  }

  self.var_cb7aa972a6412c9a = [];
  self.var_cb7aa972a6412c9a[0] = spawnStruct();
  self.var_cb7aa972a6412c9a[0].name = level.var_ec9d44662c92bb5c;
  self.var_cb7aa972a6412c9a[0].count = self.var_7f35bbdd17571a22;
  self.var_cb7aa972a6412c9a[0].var_aed5f72cc5d12c0e = 0;
  self.var_cb7aa972a6412c9a[0].countmax = 0;
  var_304dafdce0b18e69 = self.zombieaisettings.var_e58a65b7a8f5973c.overridespawnaitypearray;
  var_ebfa09adb0093c74 = 0;

  if(isDefined(var_304dafdce0b18e69) && var_304dafdce0b18e69.size > 0) {
    foreach(index, struct in var_304dafdce0b18e69) {
      self.var_cb7aa972a6412c9a[index] = spawnStruct();
      self.var_cb7aa972a6412c9a[index].name = struct.overridespawnaitype;
      self.var_cb7aa972a6412c9a[index].count = struct.var_68d9b038985f1aa5;
      self.var_cb7aa972a6412c9a[index].var_aed5f72cc5d12c0e = struct.var_aed5f72cc5d12c0e;
      self.var_cb7aa972a6412c9a[index].maxcount = struct.var_1d92b5675b8f9bd;
      var_ebfa09adb0093c74 += struct.var_68d9b038985f1aa5;
    }

    assert(var_ebfa09adb0093c74 <= self.var_7f35bbdd17571a22, "<dev string:x1c>");
  }

  assert(isDefined(self.var_cb7aa972a6412c9a) && self.var_cb7aa972a6412c9a.size > 0, "<dev string:x80>");
}

function function_e803d8fa2e7ce395() {
  self endon("death");
  wait self.var_3c9f4a3679b898c6;
  self function_3e89eb3d8e3f1811("in_summon", 1);
  self.var_78f6b2d381a73bf4 = 1;
}

function can_summon_zombies(n_to_spawn) {
  if(getdvarint(@ "hash_6489e49220d549c2", 0)) {
    return false;
  }

  if(istrue(self.var_c124ffbc8c1883e7)) {
    return false;
  }

  if(istrue(self.var_8d3cf19b73a1a3d2) && !istrue(self.var_78f6b2d381a73bf4)) {
    return false;
  }

  if(self.var_7415a936b72426f1) {
    if(self.var_cbb6735eca050540 > 0) {
      return false;
    }
  }

  if(self.summon_cooldown > gettime()) {
    return false;
  }

  n_to_spawn = default_to(n_to_spawn, self.var_7f35bbdd17571a22);

  if(getfreeaicount_sharedfunc() < n_to_spawn) {
    return false;
  }

  if(self.var_52c29781bd641d26 + n_to_spawn > self.var_16874cb97aa71c9f) {
    return false;
  }

  if(function_9bdbd82cc19b68a8() < n_to_spawn) {
    return false;
  }

  return true;
}

function function_e8bb01e68081e922() {
  self endon("death");

  while(true) {
    self waittill("summon_loop_start");

    if(istrue(self.summon_invulnerability)) {
      self.var_7878d9a79c788c74 = 1;

      if(isDefined(level.var_718ee74a7cdbfee5) && isDefined(level.players)) {
        foreach(player in level.players) {
          player[[level.var_718ee74a7cdbfee5]](1);
        }
      }
    }

    thread function_2641b2abaa5b142e();
  }
}

function function_9f02faac5e45e7ca() {
  self endon("death");
  self.var_32a7d2c687b58510 = undefined;
  self.var_32a7d2c687b58510 = function_3bd08a7c5eba1671(self.var_7f35bbdd17571a22, self.origin, 100, 150, 80);
}

function function_d378e0b40b004bca(params) {
  disciple = self.commander;

  if(isDefined(disciple) && isDefined(disciple.var_cbb6735eca050540) && isalive(disciple)) {
    disciple.var_cbb6735eca050540--;

    if(disciple.var_cbb6735eca050540 == 0 && istrue(disciple.var_7415a936b72426f1)) {
      disciple.summon_cooldown = gettime() + disciple.var_146b3cc414242deb;
      disciple function_c98c0afcd608b815(disciple.var_a4c14dc60d4dd398);
      disciple.var_90217cf570d78169 = 0;
      disciple.var_7878d9a79c788c74 = 0;

      if(isDefined(level.var_718ee74a7cdbfee5) && isDefined(level.players)) {
        foreach(player in level.players) {
          player[[level.var_718ee74a7cdbfee5]](0);
        }
      }
    }
  }
}

function function_31e1b5150e67170e(aitype) {
  spawn_point = array_get_first_item(self.var_32a7d2c687b58510);
  spawn_angles = vectortoangles(self.origin - spawn_point);
  new_zombie = spawnnewaitype_sharedfunc(aitype, spawn_point, spawn_angles, self.team);

  if(isDefined(new_zombie)) {
    if(new_zombie function_8fa69650e33c84ef("spawn")) {
      new_zombie thread animscripted_sharedfunc("spawn", "spawn_end", undefined, undefined, "spawn_animating");
    }

    new_zombie callback::add("on_ai_killed", &function_d378e0b40b004bca);

    if(istrue(self.var_446ffae9ade57ccc)) {
      new_zombie.var_f8a44d7cde24460a = 1;
    }

    if(istrue(self.var_68500b288d8cc059)) {
      new_zombie.headicon = createheadicon(new_zombie);
      setheadiconimage(new_zombie.headicon, "jup_hud_enemy_archetype_elite_white");
      setheadicondrawinmap(new_zombie.headicon, 1);
      setheadiconzoffset(new_zombie.headicon, 20);
      function_51044b10b2b673df(new_zombie.headicon, "icon_medium");
      setheadiconmaxdistance(new_zombie.headicon, self.var_a021045e9363771b);
    }

    function_1fca749b9ae92b76(new_zombie);
    self.var_52c29781bd641d26++;
    self.var_cbb6735eca050540++;
    self.var_32a7d2c687b58510 = array_remove(self.var_32a7d2c687b58510, spawn_point);

    if(self._blackboard.var_8d19c6ba087e7a86) {
      new_zombie function_ca27630def7b7aad(self);
      new_zombie.forceannihilate = 1;
    }

    return true;
  }

  return false;
}

function function_2641b2abaa5b142e() {
  level endon("game_ended");
  self endon("death");
  thread function_9f02faac5e45e7ca();
  utility::function_3ab9164ef76940fd("summon", "summon_on");

  while(true) {
    waitframe();

    if(isarray(self.var_32a7d2c687b58510)) {
      break;
    }
  }

  foreach(struct in self.var_cb7aa972a6412c9a) {
    aitype = struct.name;
    count = struct.count;
    i = 0;

    while(i < count) {
      waitframe();

      if(self.var_32a7d2c687b58510.size == 0) {
        break;
      }

      if(getfreeaicount_sharedfunc() == 0) {
        break;
      }

      if(!istrue(self getaiblackboarddynamic("in_summon"))) {
        break;
      }

      if(istrue(function_31e1b5150e67170e(aitype))) {
        i++;
        wait 2;
      }
    }

    if(istrue(self.var_7415a936b72426f1)) {
      if(istrue(struct.var_aed5f72cc5d12c0e) && struct.count < struct.maxcount) {
        struct.count++;
        self.var_7f35bbdd17571a22++;
        self.bind_max++;
      }
    }
  }

  if(istrue(self.var_7415a936b72426f1)) {
    self.var_90217cf570d78169 = 1;
  }

  utility::function_3ab9164ef76940fd("summon", "summon_off");
  self function_3e89eb3d8e3f1811("in_summon", 0);
  self.summon_cooldown = gettime() + self.var_146b3cc414242deb;
}

function private function_fb0a160d277a9416() {
  function_6e7290c8ee4f558b("<dev string:xad>");
  function_a9a864379a098ad6("<dev string:xca>", "<dev string:xda>", &force_summon);
  function_a9a864379a098ad6("<dev string:xea>", "<dev string:xfa>", &function_ebfaf249a2c588e5);
  function_a9a864379a098ad6("<dev string:x10a>", "<dev string:x123>", &function_f35637f417aa5b49);
  function_fe953f000498048f();
}

function private force_summon() {
  disciple = function_30dd4f3ef5f328ea(level.players[0].origin, undefined, undefined, "<dev string:x13d>");

  if(isDefined(disciple)) {
    disciple function_3e89eb3d8e3f1811("<dev string:x150>", 1);
  }
}

function private function_ebfaf249a2c588e5() {
  function_2fb888667001fc39("<dev string:x15d>", @ "hash_30a05f00a62a2579");
}

function private function_f35637f417aa5b49() {
  function_2fb888667001fc39("<dev string:x176>", @ "hash_6489e49220d549c2");
}

function private function_44eb214c98b6ecee(text, pos) {
  if(getdvarint(@ "hash_30a05f00a62a2579", 0)) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x190>" + text, (1, 0, 0));
  }
}

# /
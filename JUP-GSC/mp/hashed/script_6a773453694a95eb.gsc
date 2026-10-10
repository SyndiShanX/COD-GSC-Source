/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6a773453694a95eb.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_21bdef0c2290d3e2;
#using script_638d701d263ee1ed;
#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ob_disciple_bottle;

function private autoexec __init__system__() {
  system::register(#"ob_disciple_bottle", undefined, undefined, &function_eba97067b05d0ffe);
}

function function_eba97067b05d0ffe() {
  level function_54c73947b0cc64a8();

  registersharedfunc("ob_disciple_bottle", "companion_spawn_disciple", &function_502a3a9e49f2a036);
  registersharedfunc("ob_disciple_bottle", "spawn_disciple_pet", &spawn_disciple_pet);
}

function spawn_disciple_pet() {
  player = self;

  if(!isPlayer(player) || !isalive(player)) {
    return;
  }

  if(player getcurrentweapon() != nullweapon()) {}

  spawn_struct = spawnStruct();
  spawn_struct.angles = player.angles;
  forward = anglesToForward(player.angles);
  forward = vectorNormalize(forward);
  forward *= 64;
  pos = player.origin + forward;

  if(!ispointonnavmesh(pos)) {
    pos = getgroundposition(player.origin + forward, 1);

    if(!ispointonnavmesh(pos)) {
      pos = getclosestpointonnavmesh(pos);
    }
  }

  spawn_struct.origin = pos;
  aitype = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("zombie_disciple_pet")[0];
  disciple = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(aitype, spawn_struct.origin, spawn_struct.angles, player.team);

  if(isalive(disciple)) {
    player.var_209d25b535dfbcf = 1;
    player.companion_type = 3;
    disciple.var_66c1831357048c02 = player;
    player.var_c5668dcaf32afbc3 = disciple;
    disciple.teleportcooldown = 2;
    disciple.var_c124ffbc8c1883e7 = 1;
    disciple function_ca27630def7b7aad(player);
    disciple function_b6aa31e0cb281dc8();
    disciple function_b5e57408c7878df7(&function_3c10d5b169a1bb6f);
    disciple setthreatbiasgroup("team_players");
    disciple._blackboard.var_2ad5368672cc47ba = 300;
    disciple enable_pain();
    disciple thread animscriptedagent("spawn", "spawn_end", undefined, undefined, "spawn_animating");
    disciple thread behavior_watcher();
    disciple thread function_5b71b171ed50f326();
    disciple thread function_e8f6a314663565f(90000);
    disciple.headicon = createheadicon(disciple);
    setheadiconimage(disciple.headicon, "ui_jup_hud_hacking_complete_border");
    setheadicondrawinmap(disciple.headicon, 1);
    setheadiconzoffset(disciple.headicon, 20);
    function_51044b10b2b673df(disciple.headicon, "icon_small");
    disciple.var_66c8cd2e51badc67 = 1;
    disciple callback::add("on_zombie_ai_killed", &function_b29bb18f0ae7a8a5);
  }
}

function private function_b29bb18f0ae7a8a5(params) {
  if(isDefined(self.var_66c1831357048c02) && isalive(self.var_66c1831357048c02)) {
    self.var_66c1831357048c02.var_c5668dcaf32afbc3 = undefined;

    if(!istrue(self.var_66c1831357048c02.var_ded04cdd264a7e00)) {
      self.var_66c1831357048c02.companion_type = 0;
    }
  }
}

function behavior_watcher() {
  level endon("game_ended");
  self endon("death");
  wait 1;
  wait_time = 1;

  while(isalive(self)) {
    if(istrue(self.reviving)) {
      wait 2;
      continue;
    }

    if(istrue(self.var_66c1831357048c02.var_68b9486f4adbcb62)) {
      function_4dd2426d4ab62466();
      waitframe();
      continue;
    }

    if(distancesquared(self.var_66c1831357048c02.origin, self.origin) >= 3610000 && self.teleportcooldown >= 2 && !istrue(self.var_66c1831357048c02.inlaststand)) {
      function_69e98977aca657e7(self.var_66c1831357048c02.origin, 0);
      continue;
    }

    if(distancesquared(self.var_66c1831357048c02.origin, self.origin) > squared(500)) {
      function_6226a01fb62f39fd(self.var_66c1831357048c02, 2304, 3610000, 2, 150, 1, 0);
    }

    wait 0.1;
  }
}

function private function_4dd2426d4ab62466() {
  self endon("death");
  player = self.var_66c1831357048c02;

  if(isalive(player)) {
    player endon("endon_enter_walkable_vehicle");
    player endon("death_or_disconnect");
  }

  if(isDefined(player.var_cac91eb6521df629) && isDefined(player.var_cac91eb6521df629.s_exfil)) {
    player.var_cac91eb6521df629.s_exfil waittill("exfil_complete_timeout");
    var_576f57af0204c38c = player.var_cac91eb6521df629;

    if(isDefined(var_576f57af0204c38c)) {
      player waittill_notify_or_timeout("exfil_fully_completed", 20);

      if(isalive(self)) {
        function_e3952036dafb66ee();
        self kill();
      }
    }
  }
}

function function_b6aa31e0cb281dc8() {
  namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
  scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_430cb4c51653bef8", 40000));
  self.health = self.maxhealth;
}

function function_54c73947b0cc64a8() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_a9a864379a098ad6("<dev string:x23>", "<dev string:x3a>", &function_5cbd6f25b33ea5a6);
  function_fe953f000498048f();
}

function function_5cbd6f25b33ea5a6() {
  foreach(player in level.players) {
    player spawn_disciple_pet();
  }
}

# /
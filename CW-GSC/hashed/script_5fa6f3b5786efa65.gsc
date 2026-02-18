/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5fa6f3b5786efa65.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_76983b49bef66b2e;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_6d0b8a1a;

function function_44cc3493(var_2177e1d4 = 2, player) {
  self endon(#"death");
  level endon(#"game_over");

  while(var_2177e1d4 > 0) {
    var_77e4cc0b = arraysortclosest(getaiteamarray(#"axis"), self.origin);
    var_bca95f5f = [];

    foreach(guy in var_77e4cc0b) {
      if(is_true(guy.var_85a0c6e6)) {
        continue;
      }

      if(!isDefined(var_bca95f5f)) {
        var_bca95f5f = [];
      } else if(!isarray(var_bca95f5f)) {
        var_bca95f5f = array(var_bca95f5f);
      }

      var_bca95f5f[var_bca95f5f.size] = guy;
    }

    foreach(guy in var_bca95f5f) {
      if(isDefined(guy)) {
        if(is_true(guy.boss)) {
          continue;
        }

        if(is_true(guy.var_85a0c6e6)) {
          continue;
        }

        if(is_true(guy.tesla_death)) {
          continue;
        }

        in_view = util::within_fov(self.origin, self.angles, guy.origin, 0.9);

        if(!in_view) {
          continue;
        }

        self namespace_83eb6304::function_3ecfde67("teleporter_disabled");
        var_2177e1d4--;
        guy.var_85a0c6e6 = 1;
        self.org.origin = self.origin + (0, 0, 40);
        self.org namespace_83eb6304::function_3ecfde67("tesla_trail");
        self.org moveto(guy.origin + (0, 0, 40), 0.4);
        wait 0.4;
        self.org namespace_83eb6304::turnofffx("tesla_trail");
        level thread namespace_9038b9d9::function_8d45f3be(guy, player);
        wait randomfloatrange(0.4, 2);
      }
    }

    waitframe(1);
  }
}

function function_465aaf09(player, origin) {
  if(is_true(level.doa.var_41adf604)) {
    return;
  }

  if(isDefined(level.doa.var_54c5c3e6)) {
    return;
  }

  var_d98803e1 = namespace_ec06fe4a::function_65ee50ba(origin);
  origin = (origin[0], origin[1], var_d98803e1[2]);
  arcademachine = namespace_ec06fe4a::spawnmodel(origin + (0, 0, 12), "zombietron_arcademachine", player.angles + (0, 180, 0), "zombietron_arcademachine");

  if(!isDefined(arcademachine)) {
    return;
  }

  arcademachine endon(#"death");
  arcademachine.org = namespace_ec06fe4a::spawnmodel(origin + (0, 0, 12), "tag_origin", (0, 0, 0), "zombietron_arcademachine_org");

  if(!isDefined(arcademachine.org)) {
    arcademachine delete();
    return;
  }

  arcademachine.org thread namespace_ec06fe4a::function_d55f042c(arcademachine, "death");
  arcademachine thread namespace_ec06fe4a::function_d55f042c(level, "game_over");
  rooms = array("slideways", "slideways2", "slideways3", "slideways4", "slideways5");
  level.doa.var_848746c8 = is_true(level.doa.hardcoremode) ? undefined : rooms[randomint(rooms.size)];
  level.doa.var_54c5c3e6 = arcademachine;
  arcademachine namespace_e32bb68::function_3a59ec34("evt_doa_pickup_arcade_active_lp");
  arcademachine thread namespace_ec06fe4a::function_2d920b3c(1, 0);
  timeout = gettime() + 30000;

  while(timeout > gettime()) {
    if(level flag::get("doa_round_over")) {
      break;
    }

    result = level waittilltimeout(randomfloatrange(1, 4), #"exit_taken", #"arena_completed");
    arcademachine namespace_83eb6304::function_3ecfde67("lightningStrike");
    arcademachine namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
    arcademachine thread function_44cc3493(randomintrange(1, 5), player);

    if(result._notify != # "timeout") {
      break;
    }
  }

  arcademachine namespace_83eb6304::function_3ecfde67("arcade_spark");
  arcademachine notify(#"hash_7bf2519960a3852a");
  arcademachine namespace_83eb6304::function_3ecfde67("wild_portal_radial_burst");
  arcademachine namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_wilds_burst");
  arcademachine namespace_83eb6304::function_3ecfde67("turret_impact");
  arcademachine namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sentry_land");
  arcademachine moveto(arcademachine.origin + (0, 0, 3000), 1);
  level.doa.var_54c5c3e6 = undefined;
  wait 1;
  arcademachine.org namespace_83eb6304::turnofffx("tesla_trail");
  arcademachine.org delete();
  arcademachine delete();
}
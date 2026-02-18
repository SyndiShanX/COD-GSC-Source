/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4f80bd5a062c37a8.gsc
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
#using script_74a56359b7d02ab6;
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
#using scripts\core_common\vehicle_ai_shared;
#namespace namespace_7fdfcd5b;

function function_86bd7962(player, spot = player.origin, mg = 1) {
  if(mg) {
    sentry = level.doa.pickups.var_ef3f4447 spawner::spawn(1, "zombietron_sentry_spawner");
  } else {
    sentry = level.doa.pickups.var_9eec57e8 spawner::spawn(1, "zombietron_grenade_spawner");
  }

  var_540d3e16 = namespace_ec06fe4a::spawnmodel(sentry.origin);

  if(!isDefined(sentry)) {
    return;
  }

  sentry endon(#"death");
  team = player.team;
  sentry.ismissile = !mg;
  sentry.var_540d3e16 = var_540d3e16;

  if(isDefined(sentry.var_540d3e16)) {
    sentry.var_540d3e16 thread namespace_ec06fe4a::function_d55f042c(sentry, "death");
  }

  sentry.origin = spot + (0, 0, 2200);
  sentry.angles = (player.angles[0], player.angles[1], 0);
  sentry.weapon = sentry seatgetweapon(0);
  sentry turretsetontargettolerance(0, 10);
  sentry namespace_83eb6304::function_3ecfde67("player_trail_" + player.doa.color);
  sentry thread namespace_ec06fe4a::function_1a117d29(spot, 0.5);
  sentry waittill(#"movedone");
  sentry.angles = (sentry.angles[0], sentry.angles[1], 0);
  sentry.owner = player;
  sentry.ignoreme = 1;
  sentry.takedamage = 0;
  sentry setteam(team);
  sentry notsolid();
  sentry namespace_83eb6304::function_3ecfde67("turret_impact");
  sentry namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sentry_land");
  sentry thread function_229ed59f();
  sentry thread function_5945a362();
  physicsexplosionsphere(spot, 200, 128, 2);
  playrumbleonposition("grenade_rumble", spot);
  timeout = mg ? 40 : 20;
  timeout = player namespace_1c2a96f9::function_4808b985(timeout);
  level waittilltimeout(timeout, #"round_over", #"game_over");
  sentry notify(#"all_done");
  sentry namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sentry_takeoff");
  sentry namespace_83eb6304::function_3ecfde67("turret_impact");
  sentry thread namespace_ec06fe4a::function_1a117d29(sentry.origin + (0, 0, 2200), 0.5);
  sentry waittill(#"movedone");
  sentry delete();
}

function function_b44f2805() {
  self endon(#"death");

  while(isDefined(self.var_540d3e16)) {
    if(isDefined(self.favoriteenemy)) {
      if(is_true(self.ismissile)) {
        self.var_540d3e16.origin = self.origin + (self.favoriteenemy.origin - self.origin) * 0.5 + (0, 0, 1000);
      } else {
        self.var_540d3e16.origin = self.favoriteenemy.origin + (0, 0, 30);
      }
    }

    waitframe(1);
  }
}

function function_229ed59f() {
  self endon(#"death", #"all_done");
  self thread function_b44f2805();

  while(self.health > 0) {
    distsq = undefined;

    if(isDefined(self.favoriteenemy)) {
      distsq = distancesquared(self.origin, self.favoriteenemy.origin);
    }

    if(!isDefined(distsq) || distsq > sqr(200)) {
      lastenemy = self.favoriteenemy;

      if(isDefined(self.owner) && distancesquared(self.origin, self.owner.origin) < sqr(700)) {
        self.favoriteenemy = self.owner namespace_ec06fe4a::getclosestenemy();
      } else {
        self.favoriteenemy = namespace_ec06fe4a::getclosestenemy();
      }
    }

    if(lastenemy !== self.favoriteenemy) {
      self.hasseenfavoriteenemy = 0;
      self.var_43a5ac40 = 0;
    }

    if(!isDefined(self.favoriteenemy)) {
      self turretsettargetangles(0, (0, 0, 0));
    } else if(isDefined(self.var_540d3e16)) {
      self turretsettarget(0, self.var_540d3e16.origin);
    } else {
      self turretsettarget(0, self.favoriteenemy.origin + (0, 0, 30));
    }

    wait 0.5;
  }
}

function function_5945a362() {
  self endon(#"death", #"all_done");

  if(!isDefined(self.hasseenfavoriteenemy)) {
    self.hasseenfavoriteenemy = 0;
  }

  if(!isDefined(self.var_43a5ac40)) {
    self.var_43a5ac40 = 0;
  }

  wait 1.5;

  while(self.health > 0) {
    wait 0.25;

    if(isalive(self.favoriteenemy)) {
      v_origin = self gettagorigin("tag_flash");
      v_angles = self gettagangles("tag_flash");
      forward = anglesToForward(v_angles);
      enemyorigin = (self.favoriteenemy.origin[0], self.favoriteenemy.origin[1], v_origin[2]);

      if(!is_true(self.ismissile)) {
        distsq = distancesquared(enemyorigin, v_origin);

        if(distsq > sqr(512)) {
          dotrange = 0.96;
        } else if(distsq > sqr(256)) {
          dotrange = 0.93;
        } else if(distsq > sqr(128)) {
          dotrange = 0.9;
        } else {
          dotrange = 0.8;
        }

        to_obj = vectornormalize(enemyorigin - v_origin);
        dot = vectordot(to_obj, forward);

        if(dot < dotrange) {
          continue;
        }

        time = gettime();

        if(self.var_43a5ac40 < time) {
          if(self cansee(self.favoriteenemy) == 0) {
            self.var_43a5ac40 = time + 100;
            self.hasseenfavoriteenemy = 0;
            continue;
          } else {
            self.hasseenfavoriteenemy = 1;
            self.var_43a5ac40 = time + 6000;
          }
        } else {
          continue;
        }
      } else {
        to_obj = vectornormalize(enemyorigin - v_origin);
        dot = vectordot(to_obj, forward);

        if(dot < 0.7) {
          continue;
        }
      }

      if(isDefined(self.var_540d3e16)) {
        self turretsettarget(0, self.var_540d3e16.origin);
      } else {
        self turretsettarget(0, self.favoriteenemy.origin + (0, 0, 30));
      }

      firetime = randomfloatrange(3, 6);
      expiretime = gettime() + firetime * 1000;
      enemy = self.favoriteenemy;

      if(isDefined(self.var_540d3e16)) {
        enemy = self.var_540d3e16;
        enemy.var_c80846be = self.favoriteenemy;
      }

      if(!is_true(self.ismissile)) {
        while(gettime() < expiretime) {
          waitframe(1);
          v_origin = self gettagorigin("tag_flash");
          v_origin = (v_origin[0], v_origin[1], 0);
          v_angles = self gettagangles("tag_flash");
          forward = anglesToForward(v_angles);
          enemyorigin = (enemy.origin[0], enemy.origin[1], 0);
          to_obj = vectornormalize(enemyorigin - v_origin);
          dot = vectordot(to_obj, forward);

          if(dot < 0.85) {
            continue;
          }

          for(rounds = 30; rounds; rounds--) {
            self fireweapon(0, enemy, (0, 0, 30), self.owner);
            waitframe(1);
          }
        }
      } else {
        while(gettime() < expiretime) {
          if(!isDefined(self.favoriteenemy)) {
            break;
          }

          self thread function_aa217b6c(enemy);
          wait randomfloatrange(0.1, 0.45);
        }
      }

      wait 1;
    }
  }
}

function function_aa217b6c(enemy) {
  if(!isDefined(enemy)) {
    return;
  }

  if(!isDefined(level.doa.var_23e902a0)) {
    level.doa.var_23e902a0 = getweapon("zombietron_missile_turret_weapon");
  }

  v_dir = vectornormalize(enemy.origin - self.origin);
  var_a64609fe = v_dir * 200;
  owner = isDefined(self.owner) ? self.owner : self;

  if(namespace_ec06fe4a::function_a8975c67(64)) {
    missile = owner magicmissile(level.doa.var_23e902a0, self gettagorigin("tag_flash"), var_a64609fe, enemy);
    self namespace_83eb6304::function_3ecfde67("muzzleFlash_md");
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_missileturret_fire");
  }

  wait randomfloatrange(0.5, 0.8);

  if(isDefined(missile) && isDefined(enemy.var_c80846be)) {
    missile missile_settarget(enemy.var_c80846be);
  }
}
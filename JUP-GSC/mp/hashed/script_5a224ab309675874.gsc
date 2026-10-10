/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5a224ab309675874.gsc
*************************************************/

#using script_5d813d45c6b1b1be;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#namespace namespace_cf0b338237e9bb2f;

function init(var_5179c48492d1d2c2) {
  function_efabc5ae0422de9e(var_5179c48492d1d2c2);
  var_5179c48492d1d2c2.var_92ea5d02ebdbafaf = [];
  var_5179c48492d1d2c2.center_trigger = getStruct(var_5179c48492d1d2c2.target, "targetname");
  var_5179c48492d1d2c2.window_triggers = getStructArray(var_5179c48492d1d2c2.center_trigger.target, "targetname");
  thread function_78a99f6fa6a3f5de(var_5179c48492d1d2c2);

  thread function_19750c412a511f5f(var_5179c48492d1d2c2);
}

function function_78a99f6fa6a3f5de(var_5179c48492d1d2c2) {
  var_5179c48492d1d2c2 endon("MRP_HHG_NOTIFY_SUCCESS");

  while(true) {
    scripts\cp_mp\utility\game_utility::createprojectilepartition();

    foreach(projectilearray in level.projectilepartition function_df633f460888a47(var_5179c48492d1d2c2.center_trigger.origin)) {
      foreach(projectile in projectilearray) {
        if(!isDefined(projectile) || !isDefined(projectile.weapon_name)) {
          continue;
        }

        if(!array_contains(["jup_semtex_ob", "jup_frag_grenade_ob"], projectile.weapon_name)) {
          continue;
        }

        var_5179c48492d1d2c2.var_92ea5d02ebdbafaf = array_removeundefined(var_5179c48492d1d2c2.var_92ea5d02ebdbafaf);

        if(array_contains(var_5179c48492d1d2c2.var_92ea5d02ebdbafaf, projectile)) {
          continue;
        }

        foreach(window_trigger in var_5179c48492d1d2c2.window_triggers) {
          if(distancesquared(projectile.origin, window_trigger.origin) < window_trigger.radius * window_trigger.radius) {
            var_5179c48492d1d2c2.var_92ea5d02ebdbafaf = array_add(var_5179c48492d1d2c2.var_92ea5d02ebdbafaf, projectile);
            var_5179c48492d1d2c2 childthread function_9789f9ab1fa68a93(projectile);
          }
        }
      }
    }

    waitframe();
  }
}

function function_9789f9ab1fa68a93(projectile) {
  while(true) {
    if(!isDefined(projectile)) {
      self.var_92ea5d02ebdbafaf = array_remove(self.var_92ea5d02ebdbafaf, projectile);
      return;
    }

    if(distancesquared(projectile.origin, self.center_trigger.origin) < self.center_trigger.radius * self.center_trigger.radius && distancesquared(self.center_trigger.origin, projectile.owner.origin) > 250000) {
      thread function_af99b4a9d69fc433(projectile, projectile.owner);
      self notify("MRP_HHG_NOTIFY_SUCCESS");
      return;
    }

    waitframe();
  }
}

function private function_af99b4a9d69fc433(projectile, owner) {
  while(true) {
    if(!isDefined(projectile) || istrue(projectile.exploding)) {
      function_568b8a57e0fa955f(self, owner);
      namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652(owner, self.center_trigger, "ob_jup_items_activity_mrp_hhg", 1);
      return;
    }

    waitframe();
  }
}

function private function_19750c412a511f5f(var_5179c48492d1d2c2) {
  while(true) {
    if(getdvarint(@ "hash_870b2b2720067cf9", 0)) {
      sphere(var_5179c48492d1d2c2.center_trigger.origin, var_5179c48492d1d2c2.center_trigger.radius, (0, 1, 0));

      foreach(window_trigger in var_5179c48492d1d2c2.window_triggers) {
        sphere(window_trigger.origin, window_trigger.radius, (0, 1, 0));
      }
    }

    waitframe();
  }
}

# /
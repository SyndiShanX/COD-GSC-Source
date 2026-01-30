/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42826.gsc
**************************************/

main() {
  level._effect["primer_light"] = loadfx("vfx/lights/light_beacon_m990_spike");
  level._effect["na45_explosion"] = loadfx("vfx/explosion/frag_grenade_default");
  level._effect["na45_explosion_body"] = loadfx("vfx/explosion/frag_grenade_default_nodecal");
  thread monitor_na45_use();
}

is_na45(var_0) {
  if(issubstr(var_0, "m990") || issubstr(var_0, "dlcgun10loot0")) {
    return 1;
  }

  return 0;
}

monitor_na45_use() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  childthread reset_shot_on_reload();

  for(;;) {
    var_0 = self getcurrentweapon();

    if(is_na45(var_0)) {
      self.bullethitcallback = ::m990_hit;
    } else {
      self.bullethitcallback = undefined;
    }

    self waittill("weapon_change");
  }
}

transfer_primer_to_corpse(var_0, var_1) {
  self endon("primer_deleted");
  var_0 waittill("death");
  var_2 = var_0 getcorpseentity();

  if(isDefined(var_2)) {
    if(isDefined(var_1)) {
      self.primer linkto(var_2, var_1);
    } else {
      self.primer linkto(var_2);
    }

    self.primer thread show_primer_fx(self);
  }
}

m990_hit(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!is_na45(var_0)) {
    return;
  }
  if(self getcurrentweapon() != var_0) {
    return;
  }
  var_6 = get_current_shot();

  if(var_6 == "primer") {
    if(isDefined(self.primer)) {
      delete_primer();
    }

    self.primer = common_scripts\utility::spawn_tag_origin();

    if(isDefined(var_3) && (isplayer(var_3) || isagent(var_3))) {
      self.primer.origin = var_1 + var_4;
      self.primer.angles = vectortoangles(var_4 * -1);
    } else {
      self.primer.origin = var_1;
      self.primer.angles = vectortoangles(var_2);
    }

    self.primer show();
    self.primer thread show_primer_fx(self);

    if(isDefined(var_3)) {
      var_7 = var_3;

      if(isplayer(var_3) || isagent(var_3)) {
        if(isalive(var_3)) {
          thread transfer_primer_to_corpse(var_3, var_5);
        } else {
          var_8 = var_3 getcorpseentity();

          if(isDefined(var_8)) {
            var_7 = var_8;
          }
        }

        self.primer.onbody = 1;
      }

      if(isDefined(var_5)) {
        self.primer linkto(var_7, var_5);
      } else {
        self.primer linkto(var_7);
      }
    }

    thread cleanup_primer();
  } else if(isDefined(self.primer)) {
    if(distance(var_1, self.primer.origin) <= 64) {
      if(isDefined(self.primer.onbody)) {
        playFX(common_scripts\utility::getfx("na45_explosion_body"), self.primer.origin, anglesToForward(self.primer.angles));
      } else {
        playFX(common_scripts\utility::getfx("na45_explosion"), self.primer.origin, anglesToForward(self.primer.angles));
      }

      playsoundatpos(self.origin, "wpn_na45_exp");
      var_0 = self getcurrentweapon();
      var_9 = 256;
      var_10 = 130;
      var_11 = 15;

      if(issubstr(var_0, "m990loot2")) {
        var_11 = 30;
      }

      if(issubstr(var_0, "m990loot5")) {
        var_10 = 100;
        var_9 = 196;
      }

      if(issubstr(var_0, "m990loot8")) {
        var_10 = 100;
      }

      if(issubstr(var_0, "m990loot9") || issubstr(var_0, "dlcgun10loot0")) {
        var_11 = 30;
        var_10 = 150;
        var_9 = 300;
      }

      physicsexplosionsphere(self.primer.origin, 256, 32, 1.0);
      radiusdamage(self.primer.origin, var_9, var_10, var_11, self, "MOD_EXPLOSIVE", var_0);
    }

    delete_primer();
  }
}

reset_shot_on_reload() {
  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();

    if(!is_na45(var_0)) {
      self waittill("weapon_change");
      continue;
    }

    cleanup_primer_reload();
  }
}

cleanup_primer() {
  self endon("primer_deleted");
  common_scripts\utility::waittill_any("death", "disconnect", "faux_spawn");

  if(isDefined(self) && isDefined(self.primer)) {
    thread delete_primer();
  }
}

cleanup_primer_reload() {
  self endon("primer_deleted");

  if(isDefined(self) && isDefined(self.primer)) {
    thread delete_primer();
  }
}

get_current_shot() {
  var_0 = self getcurrentweaponclipammo();

  if(var_0 % 2 == 1) {
    return "primer";
  } else {
    return "catalyst";
  }
}

show_primer_fx(var_0) {
  self endon("death");
  wait 0.1;
  playfxontagforclients(common_scripts\utility::getfx("primer_light"), self, "TAG_ORIGIN", var_0);
}

delete_primer() {
  self notify("primer_deleted");
  stopFXOnTag(common_scripts\utility::getfx("primer_light"), self.primer, "TAG_ORIGIN");
  self.primer delete();
  self.primer = undefined;
}

draw_distance_line(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (1, 0, 0);
  }

  while(var_2 > 0) {
    var_2 = var_2 - 0.05;
    wait 0.05;
  }
}
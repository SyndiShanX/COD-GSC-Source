/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_na45.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

DISTANCE_TO_DETONATE = 64;

DEBUG = false;

main() {
  level._effect["primer_light"] = LoadFx("vfx/lights/light_beacon_m990_spike");
  level._effect["na45_explosion"] = LoadFx("vfx/explosion/frag_grenade_default");
  level._effect["na45_explosion_body"] = LoadFx("vfx/explosion/frag_grenade_default_nodecal");

  self thread monitor_na45_use();
}

monitor_na45_use() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self childthread reset_shot_on_reload();

  while(true) {
    weapon = self GetCurrentWeapon();
    if(IsSubStr(weapon, "m990")) {
      self.bulletHitCallback = ::m990_hit;
    } else {
      self.bulletHitCallback = undefined;
    }

    self waittill("weapon_change");
  }
}

transfer_primer_to_corpse(hit_ent, part_name) {
  self endon("primer_deleted");

  hit_ent waittill("death");

  corpse_ent = hit_ent GetCorpseEntity();
  if(isDefined(corpse_ent)) {
    if(isDefined(part_name)) {
      self.primer LinkTo(corpse_ent, part_name);
    } else {
      self.primer LinkTo(corpse_ent);
    }

    self.primer thread show_primer_fx(self);
  }
}

m990_hit(weapon, hit_pos, hit_normal, hit_ent, hit_dir, part_name) {
  if(!IsSubStr(weapon, "m990")) {
    return;
  }

  if(self GetCurrentWeapon() != weapon) {
    return;
  }

  gun = get_current_shot();

  if(gun == "primer") {
    if(isDefined(self.primer)) {
      self delete_primer();
    }

    self.primer = spawn_tag_origin();

    if(isDefined(hit_ent) && (IsPlayer(hit_ent) || IsAgent(hit_ent))) {
      self.primer.origin = hit_pos + hit_dir;
      self.primer.angles = VectorToAngles(hit_dir * -1);
    } else {
      self.primer.origin = hit_pos;
      self.primer.angles = VectorToAngles(hit_normal);
    }

    self.primer Show();

    self.primer thread show_primer_fx(self);

    if(isDefined(hit_ent)) {
      primer_link_ent = hit_ent;
      if(IsPlayer(hit_ent) || IsAgent(hit_ent)) {
        if(IsAlive(hit_ent)) {
          self thread transfer_primer_to_corpse(hit_ent, part_name);
        } else {
          corpse_ent = hit_ent GetCorpseEntity();
          if(isDefined(corpse_ent)) {
            primer_link_ent = corpse_ent;
          }
        }
        self.primer.onBody = true;
      }

      if(isDefined(part_name)) {
        self.primer LinkTo(primer_link_ent, part_name);
      } else {
        self.primer LinkTo(primer_link_ent);
      }
    }

    self thread cleanup_primer();
  } else {
    if(isDefined(self.primer)) {
      if(isDefined(DEBUG) && DEBUG) {
        IPrintLnBold(Distance(hit_pos, self.primer.origin));
        level thread draw_distance_line(hit_pos, self.primer.origin, 5);
      }

      if(Distance(hit_pos, self.primer.origin) <= DISTANCE_TO_DETONATE) {
        if(isDefined(self.primer.onBody)) {
          playFX(getfx("na45_explosion_body"), self.primer.origin, anglesToForward(self.primer.angles));
        } else {
          playFX(getfx("na45_explosion"), self.primer.origin, anglesToForward(self.primer.angles));
        }
        playSoundAtPos(self.origin, "wpn_na45_exp");

        weapon = self GetCurrentWeapon();

        radius = 256;
        max_damage = 130;
        min_damage = 15;

        if(IsSubStr(weapon, "m990loot2")) {
          min_damage = 30;
        }

        if(IsSubStr(weapon, "m990loot5")) {
          max_damage = 100;
          radius = 196;
        }

        if(IsSubStr(weapon, "m990loot8")) {
          max_damage = 100;
        }

        if(IsSubStr(weapon, "m990loot9")) {
          min_damage = 30;
          max_damage = 150;
          radius = 300;
        }

        PhysicsExplosionSphere(self.primer.origin, 256, 32, 1.0);
        RadiusDamage(self.primer.origin, radius, max_damage, min_damage, self, "MOD_EXPLOSIVE", weapon);
      }

      self delete_primer();
    }
  }
}

reset_shot_on_reload() {
  while(true) {
    self waittill("reload_start");

    weapon = self GetCurrentWeapon();
    if(!IsSubStr(weapon, "m990")) {
      self waittill("weapon_change");
      continue;
    }

    self cleanup_primer_reload();
  }
}

cleanup_primer() {
  self endon("primer_deleted");

  self waittill_any("death", "disconnect", "faux_spawn");

  if(isDefined(self) && isDefined(self.primer)) {
    self thread delete_primer();
  }
}

cleanup_primer_reload() {
  self endon("primer_deleted");

  if(isDefined(self) && isDefined(self.primer)) {
    self thread delete_primer();
  }
}

get_current_shot() {
  ammo_left = self GetCurrentWeaponClipAmmo();
  if(ammo_left % 2 == 1) {
    return "primer";
  } else {
    return "catalyst";
  }
}

show_primer_fx(player) {
  self endon("death");

  wait 0.1;
  PlayFXOnTagForClients(getfx("primer_light"), self, "TAG_ORIGIN", player);
}

delete_primer() {
  self notify("primer_deleted");

  stopFXOnTag(getfx("primer_light"), self.primer, "TAG_ORIGIN");
  self.primer Delete();
  self.primer = undefined;
}

draw_distance_line(org1, org2, timer, color) {
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  while(timer > 0) {
    Line(org1, org2, color, 1, false, 1);
    timer -= 0.05;

    wait(0.05);
  }
}
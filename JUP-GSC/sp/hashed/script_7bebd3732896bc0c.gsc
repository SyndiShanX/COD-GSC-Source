/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7bebd3732896bc0c.gsc
*************************************************/

#namespace namespace_f5515af0b7f1014c;

function main() {}

function function_f7ee9448704d5a66() {
  allies = getaiarray("allies");
  allies = sortbydistance(allies, self.origin);
  close_dist = 2000;
  med_dist = 8000;

  if(allies.size > 0) {
    dist = distance(self.origin, allies[0].origin);
    sound = "weap_tank_cannon_fire_radio_distant";

    if(dist <= close_dist) {
      sound = "weap_tank_cannon_fire_radio_close";
    } else if(dist <= med_dist) {
      sound = "weap_tank_cannon_fire_radio_med";
    }

    if(soundexists(sound)) {
      level.player playSound(sound);
    }
  }
}

function function_62f93285d84dded3(impact_origin) {
  allies = getaiarray("allies");
  allies = sortbydistance(allies, impact_origin);
  close_dist = 2000;
  med_dist = 8000;

  if(allies.size > 0) {
    dist = distance(impact_origin, allies[0].origin);
    impact_sound = "weap_rpg_exp_radio_distant";

    if(dist <= close_dist) {
      impact_sound = "weap_rpg_exp_radio_close";
    } else if(dist <= med_dist) {
      impact_sound = "weap_rpg_exp_radio_med";
    }

    if(soundexists(impact_sound)) {
      level.player playSound(impact_sound);
    }
  }
}

function function_f4edab1c90569f7c(impact_origin) {
  allies = getaiarray("allies");
  allies = sortbydistance(allies, impact_origin);
  close_dist = 2000;
  med_dist = 8000;

  if(allies.size > 0) {
    dist = distance(impact_origin, allies[0].origin);
    impact_sound = "weap_rpg_exp_radio_distant";

    if(dist <= close_dist) {
      impact_sound = "weap_rpg_exp_radio_close";
    } else if(dist <= med_dist) {
      impact_sound = "weap_rpg_exp_radio_med";
    }

    if(soundexists(impact_sound)) {
      level.player playSound(impact_sound);
    }
  }
}
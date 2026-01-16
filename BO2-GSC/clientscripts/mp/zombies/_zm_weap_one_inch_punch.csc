/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_weap_one_inch_punch.csc
***************************************************************************/

oneinchpunch_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("death");
  self endon("disconnect");
  phys_explosion_outer_radius = 75;
  phys_explosion_inner_radius = 60;

  if(newval == 1) {
    if(!isDefined(level.punching_players))
      level.punching_players = [];

    level.punching_players[self getentitynumber()] = gettime();
    self earthquake(0.5, 0.5, self.origin, 300);
    self playrumbleonentity(localclientnum, "damage_heavy");

    if(isDefined(self.b_punch_upgraded) && self.b_punch_upgraded && isDefined(self.str_punch_element) && self.str_punch_element == "air")
      phys_explosion_outer_radius = phys_explosion_outer_radius * 2;

    physicsexplosioncylinder(localclientnum, self.origin, phys_explosion_outer_radius, phys_explosion_inner_radius, 1);
  }
}

oneinchpunch_physics_launchragdoll(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("entity_shutdown");

  if(newval == 1) {
    punching_player_index = undefined;
    most_recent_punch_time = 0;

    if(isDefined(level.punching_players)) {
      for(i = 0; i < level.punching_players.size; i++) {
        if(isDefined(level.punching_players[i]) && level.punching_players[i] > most_recent_punch_time) {
          punching_player_index = i;
          most_recent_punch_time = level.punching_players[i];
        }
      }
    }

    if(isDefined(punching_player_index)) {
      a_players = getlocalplayers();
      punching_player = a_players[punching_player_index];
    }

    if(isDefined(punching_player))
      v_launch = vectornormalize(self.origin - punching_player.origin) * randomintrange(125, 150) + (0, 0, randomintrange(75, 150));

    if(isDefined(v_launch))
      self launchragdoll(v_launch);
  }
}
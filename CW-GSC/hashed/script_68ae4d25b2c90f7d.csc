/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_68ae4d25b2c90f7d.csc
***********************************************/

#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_32e85820;

function private autoexec __init__system__() {
  system::register(#"hash_36a2cb0be45d9374", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("scriptmover", "fx_heal_aoe_pillar_clientfield", 1, 1, "counter", &function_76b749e1, 1, 0);
  clientfield::register("toplayer", "fx_heal_aoe_player_clientfield", 1, 1, "counter", &function_813dcaec, 1, 0);
  clientfield::register("scriptmover", "fx_heal_aoe_bubble_clientfield", 1, 1, "int", &function_4d38c566, 1, 0);
}

function function_4d38c566(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    self.var_e648d182 = self playLoopSound(#"hash_498aaf1c4d21c2c7");
    function_239993de(fieldname, "zm_weapons/fx9_fld_healing_aura_lvl5_3p", self, "tag_origin");
    self thread function_93b178ae();
  }
}

function function_813dcaec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);

  if(isPlayer(self) && isalive(self)) {
    function_239993de(bwastimejump, "zm_weapons/fx9_fld_healing_aura_pulse_tgt", self, "j_spine4");
    playviewmodelfx(bwastimejump, "zm_weapons/fx9_fld_healing_aura_pulse_arm_le_1p", "j_elbow_le");
    playviewmodelfx(bwastimejump, "zm_weapons/fx9_fld_healing_aura_pulse_arm_ri_1p", "j_elbow_ri");
    self postfx::playpostfxbundle(#"hash_1b37bf385d33fa57");
  }
}

function function_76b749e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);

  if(isPlayer(self) && isalive(self)) {
    function_239993de(bwastimejump, "zm_weapons/fx9_fld_healing_aura_lvl0_3p", self, "tag_origin");
    self thread function_a1ae5a24();
  }
}

function function_a1ae5a24() {
  level endon(#"game_ended");
  self endon(#"death");
  wait 1;
  self delete();
}

function function_93b178ae() {
  level endon(#"game_ended");
  self endon(#"death");
  wait 10;
  self delete();
}

function function_a4b3da97(trace) {
  if(trace[# "fraction"] < 1) {
    return false;
  }

  return true;
}

function function_952f1795(localclientnum) {
  self endon(#"death");

  while(true) {
    foreach(player in getplayers(localclientnum)) {
      if(distance2d(self.origin, player.origin) < 64) {
        beamname = "beam9_zm_fld_healing_aura_pulse";
        pos = self.origin;
        otherpos = player.origin;
        trace = beamtrace(pos, otherpos, 1, self, 1);

        if(self function_a4b3da97(trace)) {
          beam_id = self beam::launch(self, "tag_origin", player, "j_spine4", beamname);
          level thread function_d7031739(localclientnum, beam_id);
        }
      }
    }

    wait 1;
  }
}

function function_d7031739(localclientnum, beamid) {
  level endon(#"game_ended");
  wait 1;
  beam::function_47deed80(localclientnum, beamid);
}
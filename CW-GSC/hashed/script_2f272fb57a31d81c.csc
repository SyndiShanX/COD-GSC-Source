/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2f272fb57a31d81c.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace missile_turret;

function init_shared() {
  if(!isDefined(level.var_7f854017)) {
    level.var_7f854017 = {};
    clientfield::register("vehicle", "missile_turret_open", 1, 1, "int", &turret_open, 0, 0);
    clientfield::register("vehicle", "missile_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
    clientfield::register("vehicle", "missile_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
    clientfield::register("vehicle", "missile_turret_is_jammed_by_cuav", 1, 1, "int", &function_c1c49ac7, 0, 0);
  }
}

function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(fieldname);
  self useanimtree("generic");
  self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
  self setanimtime(#"o_turret_mini_deploy", 0);
}

function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(fieldname);
  self function_1f0c7136(1);
  self useanimtree("generic");
  self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
}

function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function function_c1c49ac7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self.weapon.var_96850284)) {
    return;
  }

  if(bwastimejump == 1) {
    self.var_37e84ddb = playtagfxset(fieldname, self.weapon.var_96850284, self);
    return;
  }

  if(isDefined(self.var_37e84ddb)) {
    foreach(fx in self.var_37e84ddb) {
      stopfx(fieldname, fx);
    }
  }
}
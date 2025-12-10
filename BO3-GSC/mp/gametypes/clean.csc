/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\clean.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace clean;

function main() {
  clientfield::register("scriptmover", "taco_flag", 12000, 2, "int", &function_3fdcaa92, 0, 0);
  clientfield::register("allplayers", "taco_carry", 12000, 1, "int", &function_87660047, 0, 0);
}

function function_3fdcaa92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("hash_c329133d");
  if(isDefined(self.var_bc148e61)) {
    self.var_bc148e61 unlink();
    self.var_bc148e61.origin = self.origin;
  }
  self function_21017588(localclientnum);
  if(newval != 0) {
    if(!isDefined(self.var_bc148e61)) {
      self.var_bc148e61 = spawn(localclientnum, self.origin, "script_model");
      self.var_bc148e61 setModel("tag_origin");
      self thread function_8eab3bb6(localclientnum);
    }
    self.var_fd5fd3d4 = playFXOnTag(localclientnum, "ui/fx_stockpile_drop_marker", self.var_bc148e61, "tag_origin");
    setfxteam(localclientnum, self.var_fd5fd3d4, self.team);
  }
  if(newval == 1) {
    self.var_bc148e61 linkto(self);
  } else if(newval == 2) {
    self thread function_ffa114bb(localclientnum);
  }
}

function function_8eab3bb6(localclientnum) {
  self waittill("entityshutdown");
  self function_21017588(localclientnum);
  self.var_bc148e61 delete();
  self.var_bc148e61 = undefined;
}

function function_21017588(localclientnum) {
  if(isDefined(self.var_fd5fd3d4)) {
    killfx(localclientnum, self.var_fd5fd3d4);
    self.var_fd5fd3d4 = undefined;
  }
}

function function_ffa114bb(localclientnum) {
  self endon("hash_c329133d");
  self endon("entityshutdown");
  toppos = self.origin + vectorscale((0, 0, 1), 12);
  bottompos = self.origin;
  while(true) {
    self.var_bc148e61 moveto(toppos, 0.5, 0, 0);
    self.var_bc148e61 waittill("movedone");
    self.var_bc148e61 moveto(bottompos, 0.5, 0, 0);
    self.var_bc148e61 waittill("movedone");
  }
}

function function_87660047(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_d5c5a3f2(localclientnum);
  if(newval && getlocalplayer(localclientnum) != self) {
    if(!isDefined(self.var_bc148e61)) {
      self util::waittill_dobj(localclientnum);
      var_e69241e6 = self gettagorigin("j_neck");
      var_b1ff0198 = self gettagangles("j_neck");
      self.var_bc148e61 = spawn(localclientnum, var_e69241e6, "script_model");
      self.var_bc148e61 setModel("tag_origin");
      self.var_bc148e61.angles = var_b1ff0198;
      self.var_bc148e61 linkto(self, "j_neck");
      self thread function_842b9892(localclientnum);
    }
    self.var_51b02da4 = playFXOnTag(localclientnum, "ui/fx_stockpile_player_marker", self.var_bc148e61, "tag_origin");
    setfxteam(localclientnum, self.var_51b02da4, self.team);
  }
}

function function_842b9892(localclientnum) {
  self waittill("entityshutdown");
  self function_d5c5a3f2(localclientnum);
  self.var_bc148e61 delete();
  self.var_bc148e61 = undefined;
}

function function_d5c5a3f2(localclientnum) {
  if(isDefined(self.var_51b02da4)) {
    killfx(localclientnum, self.var_51b02da4);
    self.var_51b02da4 = undefined;
  }
}
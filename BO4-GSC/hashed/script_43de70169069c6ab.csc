/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_43de70169069c6ab.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_9d58c1cd;

init() {}

init_clientfields() {
  clientfield::register("toplayer", "sp_ar_pi", 1, 1, "int", &function_69a31ba8, 0, 0);
  clientfield::register("scriptmover", "elevator_rumble", 1, 1, "counter", &play_elevator_rumble, 0, 0);
  clientfield::register("world", "p_w_o_num_01", 1, getminbitcountfornum(10), "int", &function_d38f33fb, 0, 0);
  clientfield::register("world", "p_w_o_num_02", 1, getminbitcountfornum(10), "int", &function_c5199710, 0, 0);
  clientfield::register("world", "p_w_o_num_03", 1, getminbitcountfornum(10), "int", &function_68a0de20, 0, 0);
}

function

function_d38f33fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  s_number = struct::get("n_c_w_p_01");
  s_number function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

function_c5199710(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  s_number = struct::get("n_c_w_p_02");
  s_number function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

function_68a0de20(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  s_number = struct::get("n_c_w_p_03");
  s_number function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    if(isDefined(self.mdl_paper)) {
      self.mdl_paper.script_int = newval;
      self.mdl_paper.b_hidden = 1;
      self.mdl_paper function_386b1e70(localclientnum);
    } else {
      self.mdl_paper = util::spawn_model(localclientnum, self.model, self.origin, self.angles);
      self.mdl_paper.script_int = newval;
      self.mdl_paper.b_hidden = 1;
      self.mdl_paper.show_function = &function_43c140b4;
      self.mdl_paper.hide_function = &function_386b1e70;
      self.mdl_paper function_386b1e70(localclientnum);

      if(!isDefined(level.var_22a393d4)) {
        level.var_22a393d4 = [];
      } else if(!isarray(level.var_22a393d4)) {
        level.var_22a393d4 = array(level.var_22a393d4);
      }

      level.var_22a393d4[level.var_22a393d4.size] = self.mdl_paper;
    }

    return;
  }

  if(isDefined(self.mdl_paper)) {
    if(isDefined(self.mdl_paper.b_hidden) && self.mdl_paper.b_hidden) {
      self.mdl_paper.b_hidden = undefined;
    }

    self.mdl_paper.script_int = newval;
    return;
  }

  self.mdl_paper = util::spawn_model(localclientnum, self.model, self.origin, self.angles);
  self.mdl_paper.script_int = newval;
  self.mdl_paper.show_function = &function_43c140b4;
  self.mdl_paper.hide_function = &function_386b1e70;
  self.mdl_paper function_386b1e70(localclientnum);

  if(!isDefined(level.var_22a393d4)) {
    level.var_22a393d4 = [];
  } else if(!isarray(level.var_22a393d4)) {
    level.var_22a393d4 = array(level.var_22a393d4);
  }

  level.var_22a393d4[level.var_22a393d4.size] = self.mdl_paper;
}

function_386b1e70(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(self haspart(localclientnum, "tag_paper_on_1")) {
    self hidepart(localclientnum, "tag_paper_on_1");
  }

  if(self haspart(localclientnum, "tag_paper_on_2")) {
    self hidepart(localclientnum, "tag_paper_on_2");
  }

  if(self haspart(localclientnum, "tag_paper_on_3")) {
    self hidepart(localclientnum, "tag_paper_on_3");
  }

  if(self haspart(localclientnum, "tag_paper_on_4")) {
    self hidepart(localclientnum, "tag_paper_on_4");
  }

  if(self haspart(localclientnum, "tag_paper_on_5")) {
    self hidepart(localclientnum, "tag_paper_on_5");
  }

  if(self haspart(localclientnum, "tag_paper_on_6")) {
    self hidepart(localclientnum, "tag_paper_on_6");
  }

  if(self haspart(localclientnum, "tag_paper_on_7")) {
    self hidepart(localclientnum, "tag_paper_on_7");
  }

  if(self haspart(localclientnum, "tag_paper_on_8")) {
    self hidepart(localclientnum, "tag_paper_on_8");
  }

  if(self haspart(localclientnum, "tag_paper_on_9")) {
    self hidepart(localclientnum, "tag_paper_on_9");
  }

  if(self haspart(localclientnum, "tag_paper_on_0")) {
    self hidepart(localclientnum, "tag_paper_on_0");
  }

  if(self haspart(localclientnum, "tag_paper_off")) {
    self showpart(localclientnum, "tag_paper_off");
  }
}

function_43c140b4(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(self haspart(localclientnum, "tag_paper_on_1")) {
    self hidepart(localclientnum, "tag_paper_on_1");
  }

  if(self haspart(localclientnum, "tag_paper_on_2")) {
    self hidepart(localclientnum, "tag_paper_on_2");
  }

  if(self haspart(localclientnum, "tag_paper_on_3")) {
    self hidepart(localclientnum, "tag_paper_on_3");
  }

  if(self haspart(localclientnum, "tag_paper_on_4")) {
    self hidepart(localclientnum, "tag_paper_on_4");
  }

  if(self haspart(localclientnum, "tag_paper_on_5")) {
    self hidepart(localclientnum, "tag_paper_on_5");
  }

  if(self haspart(localclientnum, "tag_paper_on_6")) {
    self hidepart(localclientnum, "tag_paper_on_6");
  }

  if(self haspart(localclientnum, "tag_paper_on_7")) {
    self hidepart(localclientnum, "tag_paper_on_7");
  }

  if(self haspart(localclientnum, "tag_paper_on_8")) {
    self hidepart(localclientnum, "tag_paper_on_8");
  }

  if(self haspart(localclientnum, "tag_paper_on_9")) {
    self hidepart(localclientnum, "tag_paper_on_9");
  }

  if(self haspart(localclientnum, "tag_paper_on_0")) {
    self hidepart(localclientnum, "tag_paper_on_0");
  }

  if(self haspart(localclientnum, "tag_paper_off")) {
    self hidepart(localclientnum, "tag_paper_off");
  }

  if(isDefined(self.b_hidden) && self.b_hidden) {
    return;
  }

  if(isDefined(self.script_int)) {
    if(self.script_int == 10) {
      if(self haspart(localclientnum, "tag_paper_on_0")) {
        self showpart(localclientnum, "tag_paper_on_0");
      }

      return;
    }

    if(self haspart(localclientnum, "tag_paper_on_" + self.script_int)) {
      self showpart(localclientnum, "tag_paper_on_" + self.script_int);
    }
  }
}

play_elevator_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrumbleonentity(localclientnum, #"hash_64b33287bc9d79f5");
}

function_69a31ba8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_7d33d419)) {
    level.var_7d33d419 = [];
  }

  if(!isDefined(level.var_7d33d419[localclientnum])) {
    var_5980d6d5 = struct::get("s_cr_sp_pi");
    level.var_7d33d419[localclientnum] = util::spawn_model(localclientnum, #"hash_66161656c8ef4b2d", var_5980d6d5.origin, var_5980d6d5.angles);
  }

  level.var_7d33d419[localclientnum] endon(#"death");
  level.var_7d33d419[localclientnum] util::waittill_dobj(localclientnum);

  if(newval) {
    if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_elbow_r")) {
      level.var_7d33d419[localclientnum] showpart(localclientnum, "tag_elbow_r");
    }

    if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_wrist_r")) {
      level.var_7d33d419[localclientnum] showpart(localclientnum, "tag_wrist_r");
    }

    if(level.var_7d33d419[localclientnum] haspart(localclientnum, "TAG_SPOON")) {
      level.var_7d33d419[localclientnum] showpart(localclientnum, "TAG_SPOON");
    }

    return;
  }

  if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_elbow_r")) {
    level.var_7d33d419[localclientnum] hidepart(localclientnum, "tag_elbow_r");
  }

  if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_wrist_r")) {
    level.var_7d33d419[localclientnum] hidepart(localclientnum, "tag_wrist_r");
  }

  if(level.var_7d33d419[localclientnum] haspart(localclientnum, "TAG_SPOON")) {
    level.var_7d33d419[localclientnum] hidepart(localclientnum, "TAG_SPOON");
  }
}
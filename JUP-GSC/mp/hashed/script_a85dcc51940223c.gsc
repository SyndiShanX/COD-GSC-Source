/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_a85dcc51940223c.gsc
************************************************/

#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;
#namespace namespace_70e82607cc395cfd;

function function_2a31a579270a3a95() {
  vfx_structs = getscriptablearray("player_prox_vfx", "targetname");

  if(!isDefined(vfx_structs) || vfx_structs.size == 0) {
    vfx_structs = getentitylessscriptablearray("player_prox_vfx", "targetname");
  }

  if(!isDefined(vfx_structs) || vfx_structs.size == 0) {
    vfx_structs = getentitylessscriptablearray("scriptable_ob_floating_excavator", "classname");
  }

  foreach(vfx in vfx_structs) {
    vfx setscriptablepartstate("prox_state", "far", 1);
    radius = vfx.script_noteworthy;

    if(!isDefined(radius)) {
      radius = 500;
    }

    vfx thread function_a41a4c9aabd6ba66(radius);
  }
}

function function_a41a4c9aabd6ba66(radius) {
  self.var_9a9192b504f6e4bd = spawn("trigger_radius", self.origin, 1, radius, radius);
  self.var_9a9192b504f6e4bd.owner = self;
  self.var_9a9192b504f6e4bd.var_39c6a8e90df14505 = 1;

  if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
    [[getsharedfunc("game", "makeEnterExitTrigger")]](self.var_9a9192b504f6e4bd, &function_8974bd4a6c54efc1);
  }
}

function function_68a54b9fdf2c60ab(radius) {
  self.var_9a9192b504f6e4bd = spawn("trigger_radius", self.origin, 0, radius, radius);

  if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
    [[getsharedfunc("game", "makeEnterExitTrigger")]](self.var_9a9192b504f6e4bd, &function_8974bd4a6c54efc1, &function_3b87b9612531dc61);
  }
}

function function_8974bd4a6c54efc1(player, trigger) {
  trigger.owner setscriptablepartstate("prox_state", "near");

  if(istrue(trigger.var_39c6a8e90df14505)) {
    trigger delete();
  }
}

function function_3b87b9612531dc61(player, trigger) {
  trigger.owner setscriptablepartstate("prox_state", "far");

  if(istrue(trigger.var_39c6a8e90df14505)) {
    trigger delete();
  }
}
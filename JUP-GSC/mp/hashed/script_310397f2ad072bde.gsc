/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_310397f2ad072bde.gsc
*************************************************/

#using script_3b78d23dad7ec5be;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#namespace namespace_7062ba3752363b0;

function init_knockdown() {
  function_b5e57408c7878df7(&on_damaged);
  self.knockdowndamagethreshold = self.health * 0.01;
}

function private on_damaged(params) {
  if(isexplosivedamagemod(params.smeansofdeath) && (!isDefined(params.einflictor) || !istrue(params.einflictor.prevent_knockdown))) {
    if(params.idamage > self.knockdowndamagethreshold) {
      if(!function_e67a89537ae7d4b7()) {
        knockdown_ai(params.vpoint);
      }
    }
  }

  return params.idamage;
}
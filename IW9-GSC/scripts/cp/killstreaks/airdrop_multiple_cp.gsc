/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airdrop_multiple_cp.gsc
**********************************************************/

airdrop_multiple_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "monitorDamage", ::airdrop_multiple_monitordamage);
}

airdrop_multiple_monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650) {
  coop_handle_invuln_ac130();
}

coop_handle_invuln_ac130() {
  if(istrue(level.invulnerable_airdropmultiple_ac130s))
    self setCanDamage(0);
}
/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\airdrop_multiple_mp.gsc
**********************************************************/

airdrop_multiple_init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("airdrop_multiple", scripts\cp_mp\killstreaks\airdrop::tryuseairdropmarkerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "monitorDamage", ::airdrop_multiple_monitordamage);
}

airdrop_multiple_monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650);
}
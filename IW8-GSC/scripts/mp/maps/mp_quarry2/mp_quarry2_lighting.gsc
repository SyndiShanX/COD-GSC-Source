/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_quarry2\mp_quarry2_lighting.gsc
**************************************************************/

function main() {
  level.tweakfile = 1;
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("LQLMTQMMKQ", 1);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.35);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 1);
  setDvar("QSLRKRNKL", 2);
  setDvar("LKOLRONRNQ", 1000);
  setDvar("LTQMSPKRKO", 4);
  setDvar("MROOOROPKL", 8);
  setDvar("MNQKPNLOPT", 1);
  setDvar("NRSOTSLSSO", 1);
}
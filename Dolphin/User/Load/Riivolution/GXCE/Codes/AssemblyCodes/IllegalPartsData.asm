######################################################
Move illegal Parts Data to illegal parts [Seiken]
######################################################
# all the relevant code is (probably) from 800F79BC to 800F79CC which executes 3 times every frame, once for each robo in the current menu

# 800F79BC mulli r4, r31, 308     multiplies r31 (part base) by 308 (offset between robos)
# 800F79C0 list r3, 0x801C
# 800F79C4 addi r0, r3, 27716     loads ray 01's address into r0
# 800F79C8 add r3, r0, r4         calculates address for data matching part base
# 800F79CC lbz r0, 0x45 (r3)      stores illegal byte value in r0
# 800F79D0 cmplwi r0, 0           checks if robo is not illegal
# 800F79D4 bne ->0x800F79E0       branches, presumably to illegal handling


# need to replace instructions to use body table in expanded memory, ideally load illegal byte into r0 and resume normal code execution from 0x800F79D0

# bodies

HOOK @ $800F79BC
{
  lis r4, LocLow
  ori r4, r4, DataLocBodyHigh
  lwz r4, 0 (r4)

  mulli r3, r26, 0x4        #Slot ID in r26, store offset in r3
  add r3, r3, r4
  lwz r3, 0 (r3)            #Get pointer

  lbz r0, 0x5 (r3)          #Store illegal byte in r0
}

op nop @ $800F79C0
op nop @ $800F79C4
op nop @ $800F79C8
op nop @ $800F79CC

# guns - hook at 800f7a38, nop 800f7a3c-48

HOOK @ $800F7A38
{
  lis r4, LocLow
  ori r4, r4, DataLocGunHigh
  lwz r4, 0 (r4)

  mulli r3, r26, 0x4        #Slot ID in r26, store offset in r3
  add r3, r3, r4
  lwz r3, 0 (r3)            #Get pointer

  lbz r0, 0x0 (r3)          #Store illegal byte in r0
}

op nop @ $800F7A3C
op nop @ $800F7A40
op nop @ $800F7A44
op nop @ $800F7A48

# bombs - hook at 800f7ab4, nop 800f7ab8-c4

HOOK @ $800F7AB4
{
  lis r4, LocLow
  ori r4, r4, DataLocBombHigh
  lwz r4, 0 (r4)

  mulli r3, r26, 0x4        #Slot ID in r26, store offset in r3
  add r3, r3, r4
  lwz r3, 0 (r3)            #Get pointer

  lbz r0, 0x0 (r3)          #Store illegal byte in r0
}

op nop @ $800F7AB8
op nop @ $800F7ABC
op nop @ $800F7AC0
op nop @ $800F7AC4

# pods - hook at 800f7b30, nop 800f7b34-40

HOOK @ $800F7B30
{
  lis r4, LocLow
  ori r4, r4, DataLocPodHigh
  lwz r4, 0 (r4)

  mulli r3, r26, 0x4        #Slot ID in r26, store offset in r3
  add r3, r3, r4
  lwz r3, 0 (r3)            #Get pointer

  lbz r0, 0x0 (r3)          #Store illegal byte in r0
}

op nop @ $800F7B34
op nop @ $800F7B38
op nop @ $800F7B3C
op nop @ $800F7B40

# legs - hook at 800f7bac, nop 800f7bb0-bc

HOOK @ $800F7BAC
{
  lis r4, LocLow
  ori r4, r4, DataLocLegHigh
  lwz r4, 0 (r4)

  mulli r3, r26, 0x4        #Slot ID in r26, store offset in r3
  add r3, r3, r4
  lwz r3, 0 (r3)            #Get pointer

  lbz r0, 0x0 (r3)          #Store illegal byte in r0
}

op nop @ $800F7BB0
op nop @ $800F7BB4
op nop @ $800F7BB8
op nop @ $800F7BBC

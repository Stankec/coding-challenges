# One hundret prisoners and a lightbulb

## Problem

One hundred prisoners have been newly ushered into prison.

The warden tells them that starting tomorrow, each of them will be placed in an
isolated cell, unable to communicate amongst each other.

Each day, the warden will choose one of the prisoners uniformly at random, and
place him in a central interrogation room containing only a light bulb with a
toggle switch. The prisoner will be able to observe the current state of the
light bulb. If he wishes, he can toggle the light bulb.

He also has the option of announcing that he believes all prisoners have visited
the interrogation room at some point in time. If this announcement is true, then
all prisoners are set free, but if it is false, all prisoners are executed. The
warden leaves, and the prisoners huddle together to discuss their fate.

Can they agree on a protocol that will guarantee their freedom?

## Solution

The prisoners agree to do the following.
Each prisoner can only turn the lightbulb on and can do so only once!

E.g. if a prisoner enters the room and the light is off he has to turn it on.
If or when he goes to the room again and the light is off he leaves it that way.
If a prisoner enters a room and the light is already on, he does nothing.

They randomly pick a leader.
The leader is the only prisoner that can turn the light off.
He also has to count how many times he has turned the light off. When he counts
to n-1 (where n is the total number of prisoners in the prison), then he can
clame that all prisoners have visited the interrogation room.

---

This is a naive solution. It relies on the fact that all prisoners can enter the
interrogation room multiple times. And for this solution to work the leader has
to enter at least n-1 times which makes this algorythm very inefficient.

## Code explanation

The code uses a block to define the prisoners' strategy.
This way multiple strategies can be easily implemented and toyed with quite
quickly without the need to change the code of surrounding classes and no
'special' cases have to be introduced (like the leader prisoner).

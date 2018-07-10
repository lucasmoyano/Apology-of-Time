# Apology-of-Time
Graphic adventure game made in Flash to the youtuber "Duke apology of the obvious".

## How it was made? For who is interested in creating games.

The game planning started on 04/09/2012 and was delivered on 10/17/2012. In total 44 days of work.
My times are a little complicated ... I work 8hs from Monday to Friday, Thursday and Saturday, rehearsal with my band, when I can study, and last weekend I went to a camp. I had very little time and I was going to take care of everything, planning, design, programming and music.
I think that this shows that with a good organization you can work very efficiently.

## Planning:
Since I was very young I played Aventuras Gráficas, I was a fan of Monkey Island, Day of Tentacle, Loom, Full Trhottle, etc ... And ever since I learned to program I always wanted to make one.
My first attempt was "An Adventure of Ruock", it was about a boy who wanted to put together a ruock band to win the battle of bands that was done in school and thus conquer the girl. First you had to form the band. I had fun puzzles of virtual reality, hypnotism, voodoo, etc. I abandoned this project at approximately 50%, it was very long (2 years) and complicated, and there was no one to press me to finish it.

![alt text](https://github.com/lucasmoyano/Apology-of-Time/blob/master/assets/una%20aventura%20de%20ruock.jpg?raw=true)

This is a test of the game made in HTML5:
http://lucasmoyano.com/archivos/laboratorio/html5/


I still wanted to make a Graphic Adventure, only this time it was going to be much simpler that in a few minutes you can finish it and have something different from the conventional Graphic Adventures.
The idea arose from a game (that at this moment I can not find) that you had to click in different places and after a certain time you started from the beginning, you could see what you did before, and your past helped you.
Then the new idea was to make a Graphic Adventure with that game mode. In addition, it occurred to me to dedicate it to someone, that the main character is someone I know, who appreciates the abandonware games, for this reason I dedicated it to Duke of Apology of the Evident. And there arises the name of the game.
First I made some sketches of the levels that the game would have:


And once I had everything well defined, and knew everything I was going to need, I started working.

## Design:
I'm not a graphic designer, but I pretty much draw and animate. I could not make a serious game because my drawings are more for something funny. So try to do something fairly Maniac Mansion (although I did not get the style at all). I drew all scenarios in flash, and then the characters. This will have taken me about 10 days.

## Music:
The music was very easy for me. I armed it with ipad GarageBand. The three songs contained in the game I put together in a day.

## Programming:
First I thought about doing it in HTML5, but after trying to create some simple games I came to the conclusion that it is very green HTML5, you can make simple games but for something a little more complex does not give you the head. I thought I would do it in Unity, but I preferred to do it in Flash, which I have much more experience.

I had already programmed a Graphic Adventure and I knew what problems I could have. I did not reuse any old code. I had several problems that caused me to change or shorten the project.
The stage is very simple, it is a rectangle where you can walk. First the idea is that there are obstacles in the middle, like a tree in the middle of the room, and that you can walk behind that tree. But for that I would have to do a PathFinding, and a more complicated logic of objects in scene. So the tree and things that were obstacles in the scenarios, I left them aside to make the programming much simpler.
When playing with time, there were many coordination problems, so I had to simplify the puzzles. For example, in the cave you originally had to coordinate the two characters, and if someone was supporting the hand another could not do it. I kept that idea for a long time but it brought many problems so I simplified it to what it is now.

## Testing:
30% of the work was testing. It was full of bugs! The texts were not erased, there were objects that remained in memory and continued to work when another game started, bad coordination, characters appeared from nothing, etc.
I'm sure that the game still has errors, but none that could affect the gameplay of it.

Finally, I want to share with you the source code of the game.
It is full of patches, and several things that gives me a bit of embarrassment but I think someone could be useful. =)

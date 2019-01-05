[Mod] moss [moss]

See the forum topic for a description (other than registering a moss).

**Depends:** see [depends.txt](https://raw.githubusercontent.com/HybridDog/moss/master/depends.txt)<br/>
**License:** see [LICENSE.txt](https://raw.githubusercontent.com/HybridDog/moss/master/LICENSE.txt)<br/>
**Download:** [zip](https://github.com/HybridDog/moss/archive/master.zip), [tar.gz](https://github.com/HybridDog/moss/archive/master.tar.gz)

![I'm a screenshot!](http://i.imgur.com/rA1UXkm.png)

If you got ideas or found bugs, please tell them to me.

[How to install a mod?](http://wiki.minetest.net/Installing_Mods)


# How to register a moss node

* Add moss? do depends.txt
* Register the moss node:
```Lua
if moss then
	moss.register_moss{
		node = <string>,
		result = <string>,
		interval = <number> or 50,
		chance = <number> or 20,
		range = <number> or 3,
	}
end
```
`node` is the node where moss can grow,<br/>
`result` is the node after moss grew on it,<br/>
`interval` and `chance` are the parameters for the abm, and<br/>
`range` is the minimum distance between two moss nodes.<br/>
The last three parameters can be omitted, then the default values are used.

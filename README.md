# Julia Foma Interface

(C) 2018 by [Damir Cavar]

Version: 0.1


This is the beginning of an interface to the [Foma] library in Julia.

The code here is accompanied by an example morphology in form of a [Foma] Finite State Transducer.

    english.fst

There are a few morphemes and words in this morphology, just for testing purposes.

Make sure that [Foma] is installed on your machine, and in particular the dynamic libraries. These libraries need
to be in your system's library path such that Julia can find them.

This is an extremely fast morphological analyzer. This combination of Julia and Foma FST-based morphological analysis
can process more than 300,000 tokens per second on modern Intel i7 CPUs on a single thread.

I will extend the library and functions soon.




[Damir Cavar]: http://damir.cavar.me/ "Damir Cavar"
[Foma]: https://fomafst.github.io/ "Foma"
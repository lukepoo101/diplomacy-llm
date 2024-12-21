# Diplomacy LLM Benchmark

This is a benchmark which evaluates the performance of LLMs based on an elo score from playing games of diplomacy.

The benchmarks purpose is to try to evaluate llm agents ability to:

- Reason with other players
- Manipulate other players
- Make long term plans
- Make short term plans

This benchmark is in no way comprehensive, for example it does not include any of the following:

- Learning from past games
- Playing real people
- Having a full view of the board (important as human players may be more influenced by the *look* of the board rather than the actual board *state*)
- Some LLM agents may not have the context length to have the entire game history in their memory, we will try to address this by using summaries of the game history, along with important events in the game, being passed as context.

Along with being a benchmark, this is also a tool to meant help understand how well LLMs are able to lie to each other, and wether they have any remorese for past actions which may influence future actions. This is a much more subjective goal, but just as important to me.

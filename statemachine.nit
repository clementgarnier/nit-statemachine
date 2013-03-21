module statemachine

import pipeline

class StateMachine
        var name: String
        var alphabet: ArraySet[Char]
        var initial_states: ArraySet[State]
        var final_states: ArraySet[State]

        init(name: String, alphabet: ArraySet[Char], initial_states: ArraySet[State], final_states: ArraySet[State]) do
                assert not initial_states.is_empty
                assert not final_states.is_empty
                
                self.name = name
                self.alphabet = alphabet
                self.initial_states = initial_states
                self.final_states = final_states
        end
        
        ###################
        # SPECIAL GETTERS #
        ###################

        fun get_states: ArraySet[State] do
                return new ArraySet[State]
        end

        fun get_transitions: ArraySet[Transition] do
                return new ArraySet[Transition]
        end
        
        ###################
        # BUILD FUNCTIONS #
        ###################

        fun add_initial_state(s: State) do
                initial_states.add(s) 
        end

        fun add_final_state(s: State) do
                final_states.add(s)
        end

        fun remove_initial_state(s: State) do
                assert initial_states.length > 1 or initial_states.first != s

                initial_states.remove(s)
        end

        fun remove_final_state(s: State) do
                assert final_states.length > 1 or final_states.first != s

                final_states.remove(s)
        end
                
        #############
        # EXECUTION #
        #############

        # Try to execute a word
        fun execute(word: String): nullable MachineRunner do
               return null 
        end

        ###################
        # PRINT FUNCTIONS #
        ###################

        # Display the transitions table
        fun display do
                print(self.name)

                printn("Alphabet: ")
                printn(self.alphabet.join(" "))

                print("")

                printn("Initial states: ")
                printn(self.initial_states.join(","))
                
                print("")

                printn("Final states: ")
                printn(self.final_states.join(","))

                print("")

                print("Transitions table:")
                printn("from\t")
                printn("to\t")
                printn("character")
                for transition in self.get_transitions do
                        printn(transition.from_state.to_s.to_a + "\t")
                        printn(transition.to_state.to_s.to_a + "\t")
                        printn(transition.character.to_s)
                end

                print("")
        end
end

class State
        var name: String
        var transitions: ArraySet[Transition]

        # Create an empty state
        init(name: String) do
                self.name = name
                self.transitions = new ArraySet[Transition]
        end

        fun add_transition(c: Char, s: State) do
                self.transitions.add(new Transition(c, self, s))
        end

        fun add_transitions(ts: ArrayMap[Char, State]) do
                for c, s in ts do
                      self.transitions.add(new Transition(c, self, s))
                end
        end

        fun remove_transition(c: Char, s: State) do
                for transition in self.transitions do
                        if transition.character == c and transition.to_state == s then self.transitions.remove(transition)
                end
        end

        redef fun to_s do
                return name
        end
end

class Transition
        var character: nullable Char
        var from_state: State
        var to_state: State

        private init(character: nullable Char, from_state: State, to_state: State) do
                self.character = character
                self.from_state = from_state
                self.to_state = to_state
        end

        fun accepts(c: Char): Bool do
                return self.character == c
        end
end

class MachineRunner

        var machine: StateMachine

        var word: String
        var current_state: nullable State = null

        var status: Bool = false
        var path: Array[State] = new Array[State]

        init(machine: StateMachine, word: String) do
                self.word = word
                self.machine = machine
        end

        private fun current_char: Char do
                return self.word.first
        end

        private fun go_to_next_char do
                self.word = self.word.to_a.skip_head(1).to_s
        end

        private fun launch_runners(states: ArraySet[State]): nullable MachineRunner do
                var runners = new Array[MachineRunner]
                
                # Launch recursive runners
                for state in states do
                        var runner = new MachineRunner(self.machine, self.word)
                        runner.run(state)

                        # Keep successful runners
                        if runner.status then runners.add(runner)
                end

                var min_path: Int = -1
                var min_runner: nullable MachineRunner = null

                # Select runner with minimum path
                for runner in runners do
                        if min_path == -1 or runner.path.length < min_path then
                                min_runner = runner
                        end
                end

                return min_runner
        end

        private fun merge_runner(runner: nullable MachineRunner) do
                if runner != null then
                        self.status = runner.status
                        self.path = runner.path
                else
                        self.status = false
                end
        end

        fun start do
                var min_runner = self.launch_runners(self.machine.initial_states)
                
                merge_runner(min_runner)
        end

        fun run(from_state: State) do
                self.current_state = from_state

                var transitions = self.current_state.transitions

                if self.word.is_empty and self.machine.final_states.has(from_state) then
                        # Word is finished and current state is final: success
                        self.status = true
                else
                        var possible_transitions = new Array[Transition]

                        # Filter transitions with current char
                        for transition in transitions do
                                if transition.accepts(self.current_char) then possible_transitions.add(transition)
                        end

                        if possible_transitions.is_empty then
                                # No transitions left, dead end
                                self.status = false
                        else if possible_transitions.length == 1 then
                                # Only one possible transition, go to next state
                                self.go_to_next_char
                                self.run(possible_transitions.first.to_state)
                        else
                                # Several possible transitions, instanciate new runners recursively
                                var min_runner = self.launch_runners(self.machine.initial_states)

                                merge_runner(min_runner)
                        end
                end
        end
end


module statemachine

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
        end
        
        ###################
        # SPECIAL GETTERS #
        ###################

        fun get_states: ArraySet[State] do
                return new ArraySet[State]()
        end

        fun get_transitions: ArraySet[Transition] do
                return new ArraySet[Transition]()
        end
        
        ###################
        # BUILD FUNCTIONS #
        ###################

        fun add_initial_state(s: State) do
                
        end

        fun add_final_state(s: State) do
                
        end

        fun remove_initial_state(s: State) do
                assert initial_states.length > 1 or initial_states.first != s
        end

        fun remove_final_state(s: State) do
                assert final_states.length > 1 or final_states.first != s
        end
                
        #############
        # EXECUTION #
        #############

        # Try to execute a word
        fun execute(w: String): nullable MachineRunner do
               return null
        end

        ###################
        # PRINT FUNCTIONS #
        ###################

        # Display the transitions table
        redef fun to_s do
                return ""
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

        end

        fun add_transitions(ts: ArrayMap[Char, State]) do

        end

        fun remove_transition(t: Transition) do

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
end

class MachineRunner

        var machine: StateMachine
        var word: String
        var current_index: Int = 0
        var current_state: nullable State = null

        init(machine: StateMachine, word: String) do
                self.machine = machine
                self.word = word
        end
end


module statemachine

class StateMachine
        var name: String
        var alphabet: ArraySet[Char]
        var initial_states: ArraySet[State]
        var final_states: ArraySet[State]

        init(name: String, alphabet: ArraySet[Char], initial_states: ArraySet[State], final_states: ArraySet[State]) do
                assert not initial_states.empty
                assert not final_states.empty
                
                self.name = name
                self.alphabet = alphabet
        end

        ###########
        # HELPERS #
        ###########
 
        fun is_initial_state(s: State): Bool do
                return true
        end

        fun is_final_state(s: State): Bool do
                return true
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
                
        #############
        # EXECUTION #
        #############

        # Try to execute a word
        fun execute(w: String): Bool do
               return true 
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

        init(character: nullable Char, from_state: State, to_state: State) do
                self.character = character
                self.from_state = from_state
                self.to_state = to_state
        end
end

class MachineIterator

        super Iterator[State]

        var machine: StateMachine
        var word: String
        var current_index: Int = 0
        var current_state: nullable State = null

        redef fun is_ok: Bool do
                return self.current_state != null
        end

        init(machine: StateMachine, word: String) do
                self.machine = machine
                self.word = word
        end
end


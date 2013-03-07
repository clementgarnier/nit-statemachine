module statemachine

class StateMachine
        var name: String
        var alphabet: ArraySet[Char]
        var initial_states: ArraySet[State]
        var final_states: ArraySet[State]

        init(name: String, alphabet: ArraySet[Char]) do
                self.name = name
                self.alphabet = alphabet

                var initial_state = new State("initial state")
                var final_state = new State("final state")

                self.add_initial_state(initial_state)
                self.add_final_state(final_state)
        end

        ###########
        # HELPERS #
        ###########
 
        fun is_initial_state(s: State): Bool do
                return true
        end

        fun is_final_state: Bool do
                return true
        end
        
        fun get_state_by_name(n: String): nullable State do
               return null 
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

        # Add a state (and related transitions) to the state machine
        fun add_state(s: State) do
                # PRE CONDITION
                # One of the transitions of s must link to one of the existing states (otherwise the state is orphan)
        end

        # Unreference a state from the machine
        fun remove_state(s: State) do

        end

        fun add_initial_state(s: State) do
                
        end

        fun add_final_state(s: State) do
                
        end
                
        # Create a new state machine by combining it to another one
        # link_transitions is an ArraySet of transitions between the two machines
        fun combine(sm: StateMachine, link_transitions: ArraySet[Transition]): StateMachine do
                # PRE CONDITIONS
                # link_transitions cannot be empty
                # link_transitions must contain only transitions from machine A to machine B

                return new StateMachine("combined state machine", new ArraySet[Char]())
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

        fun add_transition(t: Transition) do

        end

        fun add_transitions(ts: ArraySet[Transition]) do

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


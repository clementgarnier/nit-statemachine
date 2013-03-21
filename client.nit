import statemachine

# Create a new alphabet
var alphabet = new ArraySet[Char]
alphabet.add('a')
alphabet.add('b')
alphabet.add('c')
alphabet.add('d')

# Create a state S1
var state1 = new State("S1")

# Add a transition from S1 to itself
state1.add_transition('b', state1)

# Create a state S2
var state2 = new State("S2")

# Add a transition from S1 to S2
state1.add_transition('c', state2)

# Add a transition from S2 to S1
state2.add_transition('d', state1)

# Add several transitions to S2
var ts = new ArrayMap[Char, State]
ts['c'] = state1
ts['d'] = state2

state2.add_transitions(ts)

# Create a new machine with S1 as initial state and S2 as final state
var initial_states = new ArraySet[State]
initial_states.add(state1)
var final_states = new ArraySet[State]
final_states.add(state2)

var sm = new StateMachine("Example State Machine", alphabet, initial_states, final_states)

sm.display

print("Running the state machine with 'bcdcd' (should be accepted)")

var runner = new MachineRunner(sm, "bcdcd")
runner.start

printn("status: ")
print(runner.status)
print(runner.path.join("->"))

print("Running the state machine with 'bccc' (should be accepted)")

runner = new MachineRunner(sm, "bccc")
runner.start

printn("status: ")
print(runner.status)
print(runner.path.join("->"))

print("Running the state machine with 'bcd' (should be accepted)")

runner = new MachineRunner(sm, "bcd")
runner.start

printn("status: ")
print(runner.status)
print(runner.path.join("->"))

print("Running the state machine with 'bd' (should be refused)")

runner = new MachineRunner(sm, "bd")
runner.start

printn("status: ")
print(runner.status)
print(runner.path.join("->"))

print("Running the state machine with 'cc' (should be refused)")

runner = new MachineRunner(sm, "cc")
runner.start

printn("status: ")
print(runner.status)
print(runner.path.join("->"))

print("Running the state machine with 'cdb' (should be refused)")

runner = new MachineRunner(sm, "cdb")
runner.start

printn("status: ")
print(runner.status)
print(runner.path.join("->"))



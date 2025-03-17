#[starknet::interface]
pub trait IStudent<TContractState> {
    fn update_age(ref self: TContractState, number: u8) -> u8;
    fn update_name(ref self: TContractState, name: felt252) -> felt252;
}

#[starknet::contract]
mod Student {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        name: felt252,
        age: u8,
    }

    #[constructor]
    fn constructor(ref self: ContractState, number: u8, name: felt252) {
        self.name.write(name);
        self.age.write(number);
    }

    #[abi(embed_v0)]
    impl StudentImpl of super::IStudent<ContractState> {
        fn update_age(ref self: ContractState, number: u8) -> u8 {
            let age = self.age.read();
            let new_age = age + number;

            self.age.write(new_age);
            return age;
        }

        fn update_name(ref self: ContractState, name: felt252) -> felt252 {
            let name = self.name.read();
            let second_name = name;
            self.name.write(second_name);
            return name;
        }
    }
    }
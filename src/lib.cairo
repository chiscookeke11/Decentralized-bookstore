#[starknet::interface]
pub trait IBookstore<TContractState>{
    fn update_books(ref self: TContractState, status: bool ) -> felt252;
    fn remove_books(ref self: TContractState, number: u8) -> u8;
}


#[starknet::contract]
mod Bookstore {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

#[storage]
struct  Storage {
    title: ByteArray,
    author: ByteArray,
    description: ByteArray,
    price: u8,
    quantity: u8,
    available: felt252,
}

#[constructor]
fn constructor(ref self: ContractState, status: bool, number: u8) {
    self.quantity.write(number);
}


#[abi(embed_v0)]
impl BookstoreImpl of super::IBookstore<ContractState> {
    fn update_books(ref self: ContractState, status: bool  ) -> felt252 {
        let available = self.available.read();
        self.available.write(available);
        return available;

    }

    fn remove_books(ref self: ContractState, number: u8) -> u8 {

        let quantity = self.quantity.read();
        let new_quantity = quantity - number;
        self.quantity.write(new_quantity);
        return quantity;

    }
}


}
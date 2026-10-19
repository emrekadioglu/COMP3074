package com.example.sqlitecompose.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.example.sqlitecompose.data.Customer
import com.example.sqlitecompose.data.CustomerDao
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.launch

class CustomerViewModel(
    private val customerDao: CustomerDao
) : ViewModel() {

    // Current search text. Blank means "show everyone".
    private val searchQuery = MutableStateFlow("")

    // Switches between getAllCustomers() and searchCustomers() automatically.
    @OptIn(ExperimentalCoroutinesApi::class)
    val customers: Flow<List<Customer>> =
        searchQuery.flatMapLatest { query ->
            if (query.isBlank()) {
                customerDao.getAllCustomers()
            } else {
                customerDao.searchCustomers(query.trim())
            }
        }

    fun addCustomer(name: String, age: Int, isActive: Boolean) {
        viewModelScope.launch {
            customerDao.insert(
                Customer(name = name, age = age, isActive = isActive)
            )
        }
    }

    fun updateCustomer(id: Int, name: String, age: Int, isActive: Boolean) {
        viewModelScope.launch {
            // Same primary key -> Room updates the existing row.
            customerDao.update(
                Customer(id = id, name = name, age = age, isActive = isActive)
            )
        }
    }

    fun deleteCustomer(customer: Customer) {
        viewModelScope.launch {
            customerDao.delete(customer)
        }
    }

    fun search(text: String) {
        searchQuery.value = text
    }

    fun clearSearch() {
        searchQuery.value = ""
    }
}

class CustomerViewModelFactory(
    private val customerDao: CustomerDao
) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(CustomerViewModel::class.java)) {
            return CustomerViewModel(customerDao) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}

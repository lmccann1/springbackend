package org.qa.repository;

import org.qa.model.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long> {
    public Account getAccountById(Long id);
    public void deleteById(Long id);
}

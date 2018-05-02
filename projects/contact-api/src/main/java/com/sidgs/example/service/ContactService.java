package com.sidgs.example.service;

import com.sidgs.example.domain.Contact;
import com.sidgs.example.dao.jpa.ContactRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.metrics.CounterService;
import org.springframework.boot.actuate.metrics.GaugeService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/*
 * Sample service to demonstrate what the API would use to get things done
 */
@Service
public class ContactService {

    private static final Logger log = LoggerFactory.getLogger(ContactService.class);

    @Autowired
    private ContactRepository contactRepository;

    @Autowired
    CounterService counterService;

    @Autowired
    GaugeService gaugeService;

    public ContactService() {
    }

    public Contact createContact(Contact contact) {
        return contactRepository.save(contact);
    }

    public Contact getContact(long id) {
        return contactRepository.findOne(id);
    }

    public void updateContact(Contact contact) {
        contactRepository.save(contact);
    }

    public void deleteContact(Long id) {
        contactRepository.delete(id);
    }


    public Page<Contact> getAllHotels(Integer page, Integer size) {
        Page pageOfContacts = contactRepository.findAll(new PageRequest(page, size));
        // example of adding to the /metrics
        if (size > 50) {
            counterService.increment("sidgs.ContactService.getAll.largePayload");
        }
        return pageOfContacts;
    }
}

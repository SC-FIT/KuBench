package com.bp.experiment.dao.model;

import java.time.Instant;
import org.hibernate.annotations.ColumnDefault;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "\"group\"")
public class Group {
    @Id
    @ColumnDefault("nextval('group_id_seq')")
    @Column(name = "id", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "name", nullable = false, length = Integer.MAX_VALUE)
    private String name;

    @NotNull
    @Column(name = "contract_signed", nullable = false)
    private Instant contractSigned;

    @Column(name = "contract_number")
    private Integer contractNumber;

    @Column(name = "institute_name", length = Integer.MAX_VALUE)
    private String instituteName;

    @NotNull
    @Column(name = "institute_address_name", nullable = false, length = Integer.MAX_VALUE)
    private String instituteAddressName;

    @Column(name = "institute_address_number", length = Integer.MAX_VALUE)
    private String instituteAddressNumber;

    @NotNull
    @Column(name = "institute_postal_code", nullable = false, length = Integer.MAX_VALUE)
    private String institutePostalCode;

    @Column(name = "province", length = Integer.MAX_VALUE)
    private String province;

    @NotNull
    @Column(name = "city", nullable = false, length = Integer.MAX_VALUE)
    private String city;

    @NotNull
    @Column(name = "country", nullable = false, length = Integer.MAX_VALUE)
    private String country;

    @Column(name = "vat", length = Integer.MAX_VALUE)
    private String vat;

    @NotNull
    @Column(name = "institute_phone", nullable = false, length = Integer.MAX_VALUE)
    private String institutePhone;

    @NotNull
    @Column(name = "institute_email", nullable = false, length = Integer.MAX_VALUE)
    private String instituteEmail;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "state_id", nullable = false)
    private Usergroupstate state;

    @NotNull
    @Column(name = "priority", nullable = false)
    private Float priority;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "responsible_user_id")
    private User responsibleUser;

}
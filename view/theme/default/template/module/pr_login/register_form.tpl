<form id="register-form" action="">
    <table class="form">
        <tr>
            <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
            <td>
                <input type="text" name="firstname" value=""/>
            </td>
        </tr>
        <tr>
            <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
            <td>
                <input type="text" name="lastname" value=""/>
            </td>
        </tr>
        <tr>
            <td><span class="required">*</span> <?php echo $entry_email; ?></td>
            <td>
                <input type="text" name="email" value=""/>
            </td>
        </tr>
        <tr>
            <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
            <td>
                <input type="text" name="telephone" value=""/>
            </td>
        </tr>
        <tr>
            <td><span class="required">*</span> <?php echo $entry_password; ?></td>
            <td>
                <input type="password" name="password" value=""/>
            </td>
        </tr>
        <tr>
            <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
            <td>
                <input type="password" name="confirm" value=""/>
            </td>
        </tr>
        <tr>
            <td><?php echo $entry_newsletter; ?></td>
            <td>
                <input type="radio" name="newsletter" value="1" checked="checked"/>
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter" value="0"/>
                <?php echo $text_no; ?>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="checkbox" name="agree" value="1" checked="checked"/>
                <?php echo $text_agree; ?>
            </td>
        </tr>
    </table>

    <input type="submit" style="display: none;"/>
</form>